import SwiftUI

struct ChatView: View {
    @ObservedObject var vm: ChatService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userData: UserData
    
    let contact: ChatContact
    
    @State private var messageText = ""
    
    init(contact: ChatContact, userData: UserData) {
        self.contact = contact
        self._vm = ObservedObject(wrappedValue: ChatService(userData: userData, contactName: contact.name))
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

            ScrollViewReader { proxy in
                ScrollView {
                    VStack(spacing: 3) {
                        ForEach(vm.messages) { message in
                            MessageBubbleView(message: message)
                        }
                        if vm.isWaitingForResponse {
                            WaitingMessageBubble()
                        }
                    }
                    .onChange(of: vm.messages) { _ in
                        scrollToBottom(proxy)
                    }
                }
                .padding(.horizontal)
            }
            Spacer()

            textField
        }
    }

    func scrollToBottom(_ proxy: ScrollViewProxy) {
        if let lastMessageId = vm.messages.last?.id {
            proxy.scrollTo(lastMessageId, anchor: .bottom)
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


struct WaitingMessageBubble: View {
    @State private var isAnimating = false
    
    var body: some View {
        HStack {
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.blue)
                    .frame(width: 10, height: 10)
                    .scaleEffect(isAnimating ? 1 : 0)
                    .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.2 * Double(index)))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
        .onAppear {
            self.isAnimating = true
        }
        .onDisappear {
            self.isAnimating = false
        }
    }
}
