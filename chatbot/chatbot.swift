import SwiftUI

@main
struct chatbot: App {
    @StateObject private var userData = UserData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userData)
        }
    }
}
