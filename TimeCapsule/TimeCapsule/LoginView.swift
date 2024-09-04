import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authManager: AuthManager
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loginError: String? = nil

    var body: some View {
        ZStack {
            Color.brandBlue.edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Email TextField
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)

                // Password SecureField
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)

                // Login Button
                Button(action: {
                    loginUser()
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.brandBlue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 30)

                if let error = loginError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }

                Spacer()
            }
            .padding()
        }
    }

    private func loginUser() {
        // Simulate login process
        guard !email.isEmpty, !password.isEmpty else {
            loginError = "Please fill in all fields"
            return
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            authManager.isAuthenticated = true // Update authentication state
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(AuthManager())
    }
}
