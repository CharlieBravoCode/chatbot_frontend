import Foundation

struct Conversation: Identifiable, Decodable {
    let id: UUID
    let contact: ChatContact
    let lastMessage: String
}

struct ChatContact: Identifiable, Decodable {
    let id: UUID
    let name: String
    let profilePicture: String
}
