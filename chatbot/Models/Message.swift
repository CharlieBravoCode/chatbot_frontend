import Foundation

struct MessageModel: Identifiable, Codable {
    var text: String
    var isCurrentUser: Bool
    var id: UUID
}


extension MessageModel {
    static var mock = [
        MessageModel(text: "Hello, this is Steve.", isCurrentUser: false, id: UUID()),
        MessageModel(text: "How can I help you?", isCurrentUser: false, id: UUID()),
        MessageModel(text: "I need advise, please", isCurrentUser: true, id: UUID()),
    ]
}
