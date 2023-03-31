//
//  chatbot_frontendApp.swift
//  chatbot_frontend
//
//  Created by Christoph Brauer on 29.03.23.
//

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
