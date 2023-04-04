import Foundation

extension HomeView {
    @MainActor class ViewModel: ObservableObject {
        @Published var userData: UserData?
        
        @Published var conversations: [Conversation] = []

        func initUserData(_ ud: UserData) {
            self.userData = ud
        }

        func getConversations() async {
            do {
                let fetchedConversations = try await HomeService().fetchConversations(authToken: userData!.authToken)
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
    }
}
