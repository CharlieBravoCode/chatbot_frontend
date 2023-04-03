import SwiftUI
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    
    let currentUser = ChatContact(id: UUID(), name: "You", profilePicture: "your_profile_picture")
    
    func loadSampleData() {
        // Load sample data
        messages = [
            Message(id: UUID(), sender: currentUser, text: "Hello!", date: Date()),
            Message(id: UUID(), sender: ChatContact(id: UUID(), text: "Hi there!", name: "Contact", profilePicture: "contact_profile_picture"), date: Date()),
            Message(id: UUID(), sender: currentUser, text: "How are you?", date: Date()),
            Message(id: UUID(), sender: ChatContact(id: UUID(), text: "I'm doing great! Thanks for asking.", name: "Contact", profilePicture: "contact_profile_picture"), date: Date())
        ]
    }
    
    func sendMessage(text: String) {
        let newMessage = Message(id: UUID(), sender: currentUser, text: text, date: Date())
        messages.append(newMessage)
    }
}
