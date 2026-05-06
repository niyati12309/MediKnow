import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: selectedTab == 0 ? "house.fill" : "house")
                }
                .tag(0)

            HistoryView()
                .tabItem {
                    Label("History", systemImage: selectedTab == 1 ? "clock.fill" : "clock")
                }
                .tag(1)

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: selectedTab == 2 ? "person.fill" : "person")
                }
                .tag(2)
        }
        .tint(Color(red: 0.04, green: 0.36, blue: 0.90))
    }
}

#Preview {
    ContentView()
}
