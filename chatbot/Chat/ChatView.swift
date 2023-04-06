import SwiftUI

struct ChatView: View {
    @StateObject var vm: ChatService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userData: UserData
    
    let contact: ChatContact
    
    @State private var messageText = ""
    
    init(contact: ChatContact, userData: UserData) {
        self.contact = contact
        self._vm = StateObject(wrappedValue: ChatService(userData: userData, contactName: contact.name))
    }
    
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
