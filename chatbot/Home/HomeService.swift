import Foundation

class HomeService {
    public func fetchConversations() async -> [Conversation] {
        let sampleConversations = [
            Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Steve Jobs", profilePicture: "steve_jobs"), lastMessage: "... one more thing"),
            Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Philip Knight", profilePicture: "philip_knight"), lastMessage: "The Shoedog"),
            Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Jedi Master Yoda", profilePicture: "yoda"), lastMessage: "Wisdome you seek?"),
            Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Jesus of Nazareth", profilePicture: "jesus"), lastMessage: "Love Incarnated"),
            Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "God of the old testment", profilePicture: "god"), lastMessage: "Sovereign Creator"),
            Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Terminator (T-800)", profilePicture: "terminator"), lastMessage: "I'll be back"),
            Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Oprah Winfrey", profilePicture: "oprah"), lastMessage: "Empowering Hearts")
        ]
        
        return sampleConversations
    }
}
