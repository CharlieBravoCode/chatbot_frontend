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
                Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Steve Jobs", profilePicture: "steve_jobs"), lastMessage: "Hey, how's it going?"),
                Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Philip Knight", profilePicture: "philip_knight"), lastMessage: "Let's catch up soon!")
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
