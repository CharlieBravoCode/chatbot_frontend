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
    }
}
