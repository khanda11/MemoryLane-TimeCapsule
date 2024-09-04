import SwiftUI

class AuthManager: ObservableObject {
    @Published var isAuthenticated: Bool = false
}

@main
struct TimeCapsuleApp: App {
    @StateObject private var authManager = AuthManager()
    @State private var showOnboarding = true // Always start with onboarding

    var body: some Scene {
        WindowGroup {
            if showOnboarding {
                OnboardingView(showOnboarding: $showOnboarding) // Show Onboarding first
            } else if authManager.isAuthenticated {
                DashboardView()
                    .environmentObject(authManager)
            } else {
                AuthView()
                    .environmentObject(authManager)
            }
        }
    }
}
