import Foundation
import Combine


extension LoginView {
    @MainActor class ViewModel: ObservableObject {
        @Published var username: String = ""
        @Published var password: String = ""
        
        @Published var authSuccessful: Bool = true
        
        @Published var errorMessage: String = ""
        
        @Published var isLoading: Bool = false
        
        func attemptLogin(userData: UserData) async {
            isLoading = true
            defer {
                isLoading = false
            }
            do {
                let token = try await AuthenticationService().login(username, password)
                userData.authToken = token
                userData.username = username // Set the username in userData
            } catch let error {
                if type(of: error) == AuthenticationService.self.AuthenticationError.self {
                    errorMessage = error.localizedDescription
                } else {
                    print("Application error: ", error.localizedDescription)
                    errorMessage = "Connection error"
                }
                authSuccessful = false
            }
        }
    }
}
