import Foundation

struct MessageModel: Identifiable, Codable, Equatable {
    var text: String
    var isCurrentUser: Bool
    var id: UUID

    static func ==(lhs: MessageModel, rhs: MessageModel) -> Bool {
        return lhs.text == rhs.text &&
            lhs.isCurrentUser == rhs.isCurrentUser &&
            lhs.id == rhs.id
    }
}
