import Foundation

class ChatService: ObservableObject {
    @Published var userName: String
    var personaName: String
    var userInput: String
    @Published var lastChatHistory: String = ""
    @Published var messages: [MessageModel] = []
    @Published var messageTextFieldPlaceholder: String = "Your question ..."
    @Published var newMessage: String = ""
    @Published var isEditing = false
    @Published var showOptionPicker = false
    @Published var selectedOption = ""
    @Published var isWaitingForResponse = false

    init(userData: UserData, contactName: String, userInput: String = "") {
        self.userName = userData.username
        self.personaName = contactName
        self.userInput = userInput
        self.lastChatHistory = lastChatHistory

        messages.append(MessageModel(text: "Hi \(self.userName)", isCurrentUser: false, id: UUID()))
        loadChatHistory()
    }

    func onSubmit() {
        if newMessage.trimmingCharacters(in: .whitespaces).isEmpty {
            return
        }
        messages.append(MessageModel(text: newMessage, isCurrentUser: true, id: UUID()))

        print("Message: ", newMessage)
        print("username: ", self.userName)
        print("personName: ", self.personaName)
        print("userInput: ", self.userInput)
        print("lastChatHistory: ", self.lastChatHistory)
        
        userInput = newMessage

        self.isWaitingForResponse = true

        Task {
            let client = GptChatClient()
            let gptPayload = GptPayload(userName: self.userName, personaName: self.personaName, userInput: self.userInput, lastChatHistory: self.lastChatHistory)
            do {
                let answer = try await client.GetChatMessage(data: ChatCreationData(gptPayload: gptPayload))
                DispatchQueue.main.async {
                    if let firstChoiceText = answer.choices.first?.text {
                        self.messages.append(MessageModel(text: firstChoiceText.trimmingCharacters(in: .whitespacesAndNewlines), isCurrentUser: false, id: UUID()))
                        self.updateLastChatHistory()
                    }
                    self.isWaitingForResponse = false
                    self.saveChatHistory()
                }
            } catch {
                print("Error occurred: \(error)")
            }
        }
        // Clear the text field
        newMessage = ""
    }

    private func saveChatHistory() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(messages) {
            UserDefaults.standard.set(encodedData, forKey: "\(userName)-\(personaName)-chatHistory")
        }
    }

    private func loadChatHistory() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "\(userName)-\(personaName)-chatHistory"),
           let decodedData = try? decoder.decode([MessageModel].self, from: data) {
            messages = decodedData
            updateLastChatHistory()
        } else {
            print("Error obtaining conversations: The data couldn’t be read because it is missing.")
        }
    }

    private func updateLastChatHistory() {
        DispatchQueue.main.async {
            let messageCount = self.messages.count
            let historyStartIndex = max(0, messageCount - 6)
            self.lastChatHistory = self.messages[historyStartIndex..<messageCount].map { $0.text }.joined(separator: "\n")
        }
    }
}
