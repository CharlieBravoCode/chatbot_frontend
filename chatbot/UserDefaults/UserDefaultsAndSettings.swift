import Foundation

struct UserSettings: Codable {
    var userName: String
    var personaName: String
    var userInput: String
}

extension UserDefaults {
    static var userSettings: UserSettings {
        get {
            guard let data = standard.data(forKey: "userSettings") else {
                return UserSettings(userName: "", personaName: "", userInput: "")
            }
            let decoder = JSONDecoder()
            guard let userSettings = try? decoder.decode(UserSettings.self, from: data) else {
                return UserSettings(userName: "", personaName: "", userInput: "")
            }
            return userSettings
        }
        set {
            let encoder = JSONEncoder()
            guard let data = try? encoder.encode(newValue) else {
                return
            }
            standard.set(data, forKey: "userSettings")
        }
    }
}
