import Foundation

class HomeService {
    public func fetchConversations() async -> [Conversation] {
        let sampleConversations = [
            Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Steve Jobs", profilePicture: "steve_jobs"), lastMessage: "Hey, how's it going?"),
            Conversation(id: UUID(), contact: ChatContact(id: UUID(), name: "Philip Knight", profilePicture: "philip_knight"), lastMessage: "Let's catch up soon!")
        ]
        
        return sampleConversations
    }
}
