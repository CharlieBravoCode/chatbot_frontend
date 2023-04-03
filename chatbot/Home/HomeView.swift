import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel()
    @EnvironmentObject var userData: UserData

    var body: some View {
        NavigationView {
            List(viewModel.conversations) { conversation in
                NavigationLink(destination: ChatView(contact: conversation.contact)) {
                    ConversationRow(conversation: conversation)
                }
            }
            .navigationTitle("Conversations")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView().environmentObject(userData)) {
                        Image(systemName: "gear")
                            .resizable()
                            .frame(width: 22, height: 22)
                    }
                }
            }
            .onAppear {
                viewModel.initUserData(userData)
                Task {
                    viewModel.loadSampleConversations()
                    await viewModel.getConversations()
                }
            }
        }
    }
}


struct ConversationRow: View {
    let conversation: Conversation

    var body: some View {
        HStack {
            Image(conversation.contact.profilePicture)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(conversation.contact.name)
                    .font(.headline)
                Text(conversation.lastMessage)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
