import Foundation

extension HomeView {
    @MainActor class ViewModel: ObservableObject {
        @Published var userData: UserData?
        @Published var conversations: [Conversation] = []
        private(set) var hasLoadedConversations = false

        func initUserData(_ ud: UserData) {
            self.userData = ud
        }

        func getConversations() async {
            do {
                let fetchedConversations = await HomeService().fetchConversations()
                conversations = fetchedConversations
            } catch let error {
                print("Error obtaining conversations")
                print(error.localizedDescription)
            }
        }
        
        func loadSampleConversations() {
            conversations = [
                Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Steve Jobs", profilePicture: "steve_jobs"), lastMessage: "... one more thing"),
                Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Philip Knight", profilePicture: "philip_knight"), lastMessage: "The Shoedog"),
                Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Jedi Master Yoda", profilePicture: "yoda"), lastMessage: "Wisdome you seek?"),
                Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Jesus of Nazareth", profilePicture: "jesus"), lastMessage: "Love Incarnated"),
                Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "God of the old testment", profilePicture: "god"), lastMessage: "Sovereign Creator"),
                Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Terminator (T-800)", profilePicture: "terminator"), lastMessage: "I'll be back"),
                Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Oprah Winfrey", profilePicture: "oprah"), lastMessage: "Empowering Hearts")
            ]
        }
        
        func updateConversationsOrder(for contactID: UUID) {
            if let index = conversations.firstIndex(where: { $0.contact.id == contactID }) {
                let conversation = conversations.remove(at: index)
                conversations.insert(conversation, at: 0)
            }
        }
        
        func setHasLoadedConversations(_ value: Bool) {
            self.hasLoadedConversations = value
        }
    }
}
