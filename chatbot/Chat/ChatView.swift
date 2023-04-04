import SwiftUI

struct ChatView: View {
    
    @StateObject var vm = ChatService(userName: UserDefaults.userSettings.userName, personaName: UserDefaults.userSettings.personaName, userInput: UserDefaults.userSettings.userInput)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let contact: ChatContact
    
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                VStack {
                    Image(contact.profilePicture)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    
                    Text(contact.name)
                        .font(.headline)
                        .foregroundColor(.black)
                }

                Spacer()
            }
            .padding()
            .background(Color.black.opacity(0.05))

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
