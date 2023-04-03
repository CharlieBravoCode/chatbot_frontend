import SwiftUI

struct ChatView: View {
    @StateObject private var viewModel = ChatViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let contact: ChatContact
    
    @State private var messageText = ""
    
    var body: some View {
        VStack {
            List(viewModel.messages) { message in
                MessageRow(message: message, isCurrentUser: message.sender.id == viewModel.currentUser.id)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                    }
                }
                
                ToolbarItem(placement: .principal) {
                    VStack {
                        Image(contact.profilePicture)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                        Text(contact.name)
                            .font(.headline)
                    }
                }
            })
            
            HStack {
                TextField("Type a message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(8)
                
                Button(action: {
                    viewModel.sendMessage(text: messageText)
                    messageText = ""
                }) {
                    Image(systemName: "paperplane.fill")
                        .padding(8)
                }
            }
            .padding([.horizontal], 8)
        }
        .onAppear {
            viewModel.loadSampleData()
        }
    }
}

struct MessageRow: View {
    let message: Message
    let isCurrentUser: Bool

    var body: some View {
        HStack {
            if isCurrentUser {
                Spacer()
            }
            Text(message.text)
                .padding(8)
                .background(isCurrentUser ? Color.blue : Color.gray.opacity(0.1))
                .foregroundColor(isCurrentUser ? .white : .black)
                .cornerRadius(8)
            if !isCurrentUser {
                Spacer()
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(contact: ChatContact(id: UUID(), name: "Steve Jobs", profilePicture: "steve_jobs"))
    }
}

