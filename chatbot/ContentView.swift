import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var userData: UserData
    var body: some View {
        if userData.authToken == "" {
            AuthenticationView()
        } else {
            HomeView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
