import Foundation

fileprivate struct FetchConversationsParams: Codable {
    let token: String

    init(_ authToken: String) {
        self.token = authToken
    }
}

fileprivate struct ConversationResponse: Decodable {
    let status_code: Int
    let message: String?
    let conversations: [Conversation]?
}

class HomeService {
    public func fetchConversations(authToken: String) async throws -> [Conversation] {
        let apiEndpoint = URL(string: "http://127.0.0.1:1234/conversations")!
        var request = URLRequest(url: apiEndpoint)

        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let bodyParams = FetchConversationsParams(authToken)

        let bodyData = try JSONEncoder().encode(bodyParams)

        request.httpBody = bodyData

        let session = URLSession.shared

        let (responseData, _) = try await session.data(for: request)

        let decoded = try JSONDecoder().decode(ConversationResponse.self, from: responseData)

        if decoded.status_code < 200 || decoded.status_code > 299 {
            if decoded.message == nil {
                throw FetchConversationsError(serverMessage: "An error has occurred attempting to fetch data.")
            }
            throw FetchConversationsError(serverMessage: decoded.message!)
        }

        return decoded.conversations!
    }

    public struct FetchConversationsError: LocalizedError {
        public var errorDescription: String?

        init(serverMessage: String) {
            self.errorDescription = serverMessage
        }
    }
}

