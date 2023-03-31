import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = ViewModel() // Updates the view when something is changed

    @EnvironmentObject var userData: UserData

    var body: some View {
        NavigationView {
            List(viewModel.conversations) { conversation in
                ConversationRow(conversation: conversation)
            }
            .navigationTitle("Conversations")
            .onAppear {
                viewModel.initUserData(userData)
                Task {
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
