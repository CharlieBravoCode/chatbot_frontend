import Foundation
class GptChatClient {

    private let url: URL = URL(string: "http://127.0.0.1:1234/mobile_v1_3JzJkq6mvZ4A2U8BDokUtDKFlV1sVBwl/chat")!
    private let urlSession: URLSession = .shared

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()


    public func GetChatMessage(data: ChatCreationData) async throws -> GptResponse {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [
            URLQueryItem(name: "userName", value: data.gptPayload.userName),
            URLQueryItem(name: "personaName", value: data.gptPayload.personaName),
            URLQueryItem(name: "userInput", value: data.gptPayload.personaName),
        ]
        
        guard let finalURL = urlComponents?.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: finalURL)

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        request.httpMethod = "GET"

        let (data, response) = try await urlSession.data(for: request)
        print(String(data: data, encoding: .utf8))
        return try decoder.decode(GptResponse.self, from: data)
    }

}
struct GptResponse: Decodable {
   
}
struct GptPayload: Encodable {
    var userName: String
    var personaName: String
    var userInput: String
}
struct ChatCreationData {
    var gptPayload: GptPayload
}
