import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var userData: UserData
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all) // Set the gray background
            
            if userData.authToken == "" {
                AuthenticationView()
            } else {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
