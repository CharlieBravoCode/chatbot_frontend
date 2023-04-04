import SwiftUI

struct ChatView: View {
    
    @StateObject var vm = ChatService(userName: UserDefaults.userSettings.userName, personaName: UserDefaults.userSettings.personaName, userInput: UserDefaults.userSettings.userInput)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let contact: ChatContact
    
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            HStack {
                Circle()
                    .fill(Color.green)
                    .frame(width: 10, height: 10)

                Text("Placeholder Name")
                    .font(.headline)
                    .foregroundColor(.white)

                Spacer()

                Text("...")
                    .font(.footnote)
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color(red: 0.1, green: 0.1, blue: 0.1))

            ScrollView {
                VStack(spacing: 3) {
                    ForEach(vm.messages) { message in
                        MessageBubbleView(message: message)
                    }
                }
            }
            .padding(.horizontal)
            Spacer()

            Spacer()
            textField
        }
    }

    var textField: some View {
        HStack {
            TextField(vm.messageTextFieldPlaceholder, text: $vm.newMessage)
                .textFieldStyle(.roundedBorder)
                .onSubmit(vm.onSubmit)

            Button(action: vm.onSubmit) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 32))
            }
            .disabled(vm.newMessage.isEmpty)
        }
        .padding()
    }
}




