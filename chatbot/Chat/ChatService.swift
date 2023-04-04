import Foundation

class ChatService: ObservableObject {
    
    var userName: String
    var personaName: String
    var userInput: String
    
    @Published var messages: [MessageModel] = []
    @Published var messageTextFieldPlaceholder:String = "Your question ..."
    @Published var newMessage: String = ""
    @Published var isEditing = false
    @Published var showOptionPicker = false
    @Published var selectedOption = ""
    
    private let options = ["Steve Jobs", "Phil Knight"]
    private let endpointUrl = "https://api.openai.com/v1/completions"
    private let apiKey = "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"

    init(userName: String, personaName: String, userInput: String) {
        self.userName = userName
        self.personaName = personaName
        self.userInput = userInput
        
        let chatSessionInfo = UserDefaults.standard.codableObject(dataType: ChatSessionInfo.self, key: "chatSessionInfo")
        
        if (chatSessionInfo != nil) {
            
            //get current date
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let dateString = dateFormatter.string(from: currentDate)
            
            if (chatSessionInfo?.hasInitialMessage == false){
                messages.append(MessageModel(text: "Hi \(userName), what can I do for you? :) ", isCurrentUser: false, id: UUID()))
                messages.append(MessageModel(text: "", isCurrentUser: false, id: UUID()))
                
                //Set ChatSessionInfo
                var initialChatSessionInfo = ChatSessionInfo(messages: messages, hasInitialMessage: false, numberOfUserRequests: 0)
                UserDefaults.standard.setCodableObject(initialChatSessionInfo, forKey: "chatSessionInfo")
                
                Task{
                
                //request chat //TODO: Fetch from API
                var client = GptChatClient()
                var gptPayload = GptPayload(userName: self.userName, personaName: self.personaName , userInput: self.userInput)
                    var answer: GptResponse
                    
                    
                    do {
                        try answer = await client.GetChatMessage(data:ChatCreationData(gptPayload:gptPayload))
                        print("here is the answer: \(answer)")
                    } catch {
                        print("error occurred")
                    }
                }
                let initialMessage = "<this is a message>"
                messages.append(MessageModel(text: initialMessage, isCurrentUser: false, id:UUID()))
                
                //Ask for questions related to
                messages.append(MessageModel(text: "If you have any questions, or want to dive deeper, please ask me.", isCurrentUser: false, id:UUID()))
                
                //Set ChatSessionInfo
                initialChatSessionInfo = ChatSessionInfo(messages: messages, hasInitialMessage: true, numberOfUserRequests: 0)
                UserDefaults.standard.setCodableObject(initialChatSessionInfo, forKey: "chatSessionInfo")
                
            }
        }
    }
        
    func onSubmit() {
        
            
        let initialChatSessionInfo = ChatSessionInfo(messages: [], hasInitialMessage: true, numberOfUserRequests: 0)
            UserDefaults.standard.setCodableObject(initialChatSessionInfo, forKey: "chatSessionInfo")

        
            messages.append(MessageModel(text: "Now its your turn! What do you want to know", isCurrentUser: false, id: UUID()))
        
        
        if newMessage.trimmingCharacters(in: .whitespaces).isEmpty {
             //Show an error message or alert the user that the question is
            return
        }
        messages.append(MessageModel(text: newMessage, isCurrentUser: true, id: UUID()))
        newMessage = ""
    }
    
    
  
    func calculateAnswer(question: String, completion: @escaping (String) -> Void) {
        let payload: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": question,
            "temperature": 0,
            "max_tokens": 128,
        ]
        
        // Create the request
        var request = URLRequest(url: URL(string: endpointUrl)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: payload)
        
        // Send the request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let data = data {
                do {
                    // Parse the response
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                    if let json = json, let answerData = json["choices"] as? [[String: Any]], let text = answerData[0]["text"] as? String {
                        completion(text)
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }
        task.resume()
    }
}
