import Foundation

struct MessageModel: Identifiable, Codable {
    var text: String
    var isCurrentUser: Bool
    var id: UUID
}


