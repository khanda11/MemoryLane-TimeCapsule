import SwiftUI

struct OnboardingView: View {
    @Binding var showOnboarding: Bool // Binding to control showing onboarding
    @State private var currentPage = 0 

    var body: some View {
        ZStack {
            Color.brandBlue.edgesIgnoringSafeArea(.all)

            VStack {
                TabView(selection: $currentPage) {
                    OnboardingPageView(
                        imageName: "MemoryLane-", // Logo image
                        title: "Welcome to MemoryLane!",
                        description: "Your time capsule for treasured moments. Here, you can create entries that will be unlocked on a future date."
                    )
                    .tag(0)

                    OnboardingPageView(
                        imageName: "lock.fill",
                        title: "Create an Entry",
                        description: "Click on the 'Create New Entry' button on the dashboard to add a new memory to your capsule."
                    )
                    .tag(1)

                    OnboardingPageView(
                        imageName: "calendar",
                        title: "Set Unlock Date",
                        description: "Choose a future date for when you want your entry to be unlocked and visible."
                    )
                    .tag(2)

                    OnboardingPageView(
                        imageName: "list.bullet",
                        title: "Manage Entries",
                        description: "View all your entries on the 'Dashboard' screen. Locked entries will show a lock icon and the unlock date."
                    )
                    .tag(3)
                }
                .tabViewStyle(PageTabViewStyle()) // Enable paging
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))

                Button(action: {
                    if currentPage < 3 {
                        currentPage += 1
                    } else {
                        showOnboarding = false // Dismiss onboarding
                    }
                }) {
                    Text(currentPage < 3 ? "Next" : "Get Started")
                        .foregroundColor(.brandBlue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
            }
            .padding()
        }
    }
}

struct OnboardingPageView: View {
    var imageName: String
    var title: String
    var description: String

    var body: some View {
        VStack {
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 150, maxHeight: 150)
                .padding(.bottom, 40)

            Text(title)
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding(.bottom, 20)

            Text(description)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding(.horizontal, 40)

            Spacer()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(showOnboarding: .constant(true))
            .preferredColorScheme(.dark)
    }
}
