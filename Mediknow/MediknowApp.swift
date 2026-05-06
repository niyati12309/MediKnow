import SwiftUI

@main
struct MediknowApp: App {
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation(.easeInOut(duration: 0.6)) {
                                showSplash = false
                            }
                        }
                    }
            } else {
                ContentView()
                    .transition(.opacity)
            }
        }
    }
}
