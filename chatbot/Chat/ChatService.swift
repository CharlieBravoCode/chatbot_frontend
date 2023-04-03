import Foundation

class ChatService {
    
    func fetchMessages(for conversation: Conversation, completion: @escaping ([Message]) -> Void) {
        // Replace this with real data fetching logic
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let messages = [
                Message(id: 1, sender: Contact(id: 0, name: "You", profilePicture: "your_profile_picture"), text: "Hello!", date: Date().addingTimeInterval(-3600)),
                Message(id: 2, sender: conversation.contact, text: "Hey, how are you?", date: Date().addingTimeInterval(-1800)),
                Message(id: 3, sender: Contact(id: 0, name: "You", profilePicture: "your_profile_picture"), text: "I'm doing great, thanks for asking!", date: Date().addingTimeInterval(-900)),
                Message(id: 4, sender: conversation.contact, text: "Glad to hear that!", date: Date().addingTimeInterval(-300))
            ]
            completion(messages)
        }
    }
}
