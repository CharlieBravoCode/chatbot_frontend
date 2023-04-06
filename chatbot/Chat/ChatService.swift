import Foundation

class ChatService: ObservableObject {
    @Published var userName: String
    var personaName: String
    var userInput: String

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

        self.isWaitingForResponse = true

        Task {
            let client = GptChatClient()
            let gptPayload = GptPayload(userName: self.userName, personaName: self.personaName, userInput: self.userInput)
            do {
                let answer = try await client.GetChatMessage(data: ChatCreationData(gptPayload: gptPayload))
                DispatchQueue.main.async {
                    if let firstChoiceText = answer.choices.first?.text {
                        self.messages.append(MessageModel(text: firstChoiceText.trimmingCharacters(in: .whitespacesAndNewlines), isCurrentUser: false, id: UUID()))
                    }
                    self.isWaitingForResponse = false
                }
            } catch {
                print("Error occurred: \(error)")
            }
        }
        // Clear the text field
        newMessage = ""
    }
}
