import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var userData: UserData // Obtain EnvironmentObject user data
    var body: some View {
        VStack {
            PageHeader(titleName: "")
            CaptionedTextField(caption: "Username", text: $viewModel.username, placeholder: "Enter a username")
            ViewableSecureField(caption: "Password", text: $viewModel.password, placeholder: "Enter a password")
            ViewableSecureField(caption: "Confirm Password", text: $viewModel.confirmedPassword, placeholder: "Enter password again")
            CaptionedTextField(caption: "Given Name / Surname", text: $viewModel.location, placeholder: "Enter Your  Name (optional)")
            if viewModel.errorMessage != "" {
                Text(viewModel.errorMessage)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(Color.red)
                    
            }
            SubmitButton(text: "Create Account", backgroundColor: Color.blue, submitAction: { await viewModel.attemptCreateAccount(userData: userData)})
        }.fullScreenCover(isPresented: $viewModel.isLoading) {
            ZStack {
                Color.black.opacity(0.1)
                    .ignoresSafeArea(edges: [.all])
                ProgressView()
            }
            .background(BlurredBackground())
        }.onAppear {
            UIView.setAnimationsEnabled(false)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
