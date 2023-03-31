import Foundation

struct Conversation: Identifiable, Decodable {
    let id: UUID
    let contact: Contact
    let lastMessage: String
}

struct Contact: Decodable {
    let id: UUID
    let name: String
    let profilePicture: String
}
