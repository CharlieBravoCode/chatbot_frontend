import Foundation

struct ChatSessionInfo: Codable {
    var messages: [MessageModel]
    var hasInitialMessage: Bool
    var numberOfUserRequests: Int
}
