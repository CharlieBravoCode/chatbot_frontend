import Foundation

extension RegisterView {
    @MainActor class ViewModel: ObservableObject {
        // Input variables
        @Published var username: String = ""
        @Published var password: String = ""
        @Published var confirmedPassword: String = ""
        @Published var location: String = ""
        
        @Published var isLoading: Bool = false
        
        @Published var errorMessage: String = ""
        
        func attemptCreateAccount(userData: UserData) async {

            if password != confirmedPassword {
                errorMessage = "Passwords do not match"
                return
            }
            // Do regular expression checking
            let validator = InputValidator()
                
            if validator.validateUsername(username: username) == false {
                errorMessage = "Invalid username. Username must be at least 6 characters and can only contain alphanumeric characters and at least one alphabet character"
                return
            }
            
            if validator.validatePassword(password: password) == false {
                errorMessage = "Invalid password. Password must be at least 6 characters. Only symbols allowed: !,@,#,$,%,^,&,*,(,),{,},<,>,.,;"
            }
            
            if location != "" {
                if validator.validateLocation(location: location) == false {
                    errorMessage = "Invalid location entered"
                }
            }
            
            do {
                isLoading = true
                defer {
                    isLoading = false
                }
                let authToken = try await AuthenticationService().registerAccount(username, password, location)
                userData.authToken = authToken
            } catch let error {
                print(error.localizedDescription)
                if type(of: error) == AuthenticationService.self.AuthenticationError.self {
                    print("API Call Error")
                    errorMessage = error.localizedDescription
                } else {
                    print("SwiftUI Error")
                    errorMessage = "The application encountered an error"
                }
            }
        }
        
    }
}
