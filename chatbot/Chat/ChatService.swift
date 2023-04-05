import Foundation

class ChatService: ObservableObject {
    var userName: String
    var personaName: String
    var userInput: String

    @Published var messages: [MessageModel] = []
    @Published var messageTextFieldPlaceholder: String = "Your question ..."
    @Published var newMessage: String = ""
    @Published var isEditing = false
    @Published var showOptionPicker = false
    @Published var selectedOption = ""

    init(userName: String, personaName: String, userInput: String = "") {
        self.userName = "Tom"
        self.personaName = "Steve Jobs"
        self.userInput = userInput

        messages.append(MessageModel(text: "Hi \(self.userName)", isCurrentUser: false, id: UUID()))
    }

    func onSubmit() {
        if newMessage.trimmingCharacters(in: .whitespaces).isEmpty {
            return
        }
        messages.append(MessageModel(text: newMessage, isCurrentUser: true, id: UUID()))
        userInput = newMessage
        print("Message: ", newMessage)
        print("username: ", self.userName)
        print("personName: ", self.personaName)
        print("userInput: ", self.userInput)

        Task {
            let client = GptChatClient()
            let gptPayload = GptPayload(userName: self.userName, personaName: self.personaName, userInput: self.userInput)
            do {
                let answer = try await client.GetChatMessage(data: ChatCreationData(gptPayload: gptPayload))
                DispatchQueue.main.async {
                    if let firstChoiceText = answer.choices.first?.text {
                        self.messages.append(MessageModel(text: firstChoiceText.trimmingCharacters(in: .whitespacesAndNewlines), isCurrentUser: false, id: UUID()))
                    }
                }
            } catch {
                print("Error occurred: \(error)")
            }
        }
    }
}
