import Foundation

struct Message: Identifiable {
    let id: Int
    let sender: ChatContact
    let text: String
    let date: Date
}
