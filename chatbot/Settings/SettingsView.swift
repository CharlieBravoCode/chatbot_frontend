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
        VStack {
            PageHeader(titleName: "")
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Text("User ID:")
                            .font(.system(size: 20, weight: .bold))
                        Text("\(viewModel.user_id)")
                            .font(.system(size: 20))
                    }
                    HStack {
                        Text("Username:")
                            .font(.system(size: 20, weight: .bold))
                        Text("\(viewModel.username)")
                            .font(.system(size: 20))
                    }
                    HStack {
                        Text("Location:")
                            .font(.system(size: 20, weight: .bold))
                        Text("\(viewModel.location)")
                            .font(.system(size: 20))
                    }
                }.padding([.leading], 40)
                Spacer()
            }
            
            SubmitButton(text: "Logout", backgroundColor: Color.red, submitAction: viewModel.logout)
                .padding([.top], 15)
            
            Spacer()
        }
        .background(Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)) // Add the gray background
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
