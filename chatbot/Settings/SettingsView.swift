import SwiftUI

#if DEBUG
import UIKit

extension UIApplication {
    static let isRunningInPreview = UIDevice.current.name.contains("Preview")
}
#endif

struct SettingsView: View {
    @StateObject private var viewModel = ViewModel() // Updates the view when something is changed
    
    @EnvironmentObject var userData: UserData

    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Text("Username:")
                            .font(.system(size: 20, weight: .bold))
                        Spacer()
                        Text("\(viewModel.username)")
                            .font(.system(size: 20))
                    }
                }
                Section {
                    Button(action: viewModel.logout) {
                        Text("Logout")
                            .foregroundColor(.red)
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle("Settings")
            .onAppear {
                viewModel.initUserData(userData)

                #if DEBUG
                if !UIApplication.isRunningInPreview {
                    Task {
                        await viewModel.getUserData()
                        viewModel.updateDisplay()
                    }
                }
                #else
                Task {
                    await viewModel.getUserData()
                    viewModel.updateDisplay()
                }
                #endif
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(createMockUserData())
    }
    
    static func createMockUserData() -> UserData {
        let mockUserData = UserData()
        mockUserData.user_id = 1
        mockUserData.username = "JohnDoe"
        mockUserData.location = "New York"
        mockUserData.authToken = "mock_token"
        
        return mockUserData
    }
}
