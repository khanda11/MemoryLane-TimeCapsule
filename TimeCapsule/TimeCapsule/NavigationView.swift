import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authManager: AuthManager

    var body: some View {
        NavigationView {
            ZStack {
                Color.brandBlue // Use your custom brand color
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer() // Push content towards the center

                    Image("MemoryLane-") // Use the custom logo image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: UIScreen.main.bounds.width * 1.5)
                        .padding(.bottom, 40)

                    Spacer() // Add spacer for bottom spacing

                    
                    NavigationLink(destination: LoginView().environmentObject(authManager)) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.brandBlue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    }
                    .padding(.horizontal, 30)

                    // Register Button
                    NavigationLink(destination: RegisterView().environmentObject(authManager)) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.brandBlue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(color: .gray, radius: 5, x: 0, y: 5)
                    }
                    .padding(.horizontal, 30)
                    
                    Spacer() // Add another spacer to balance layout
                }
                .padding()
            }
            .navigationBarHidden(true)  // Hide default navigation bar
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView().environmentObject(AuthManager())
    }
}
