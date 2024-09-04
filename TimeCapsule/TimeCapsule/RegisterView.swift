import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authManager: AuthManager // Use EnvironmentObject to access shared state
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var registrationError: String? = nil
    @State private var showSuccessMessage: Bool = false // State to control success message
    @State private var showInstructionsModal: Bool = false // State to control instructions modal

    var body: some View {
        ZStack {
            Color.brandBlue.edgesIgnoringSafeArea(.all) // Background color

            VStack(spacing: 20) {
                Spacer()

                Text("Register")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)

                TextField("Email", text: $email)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)

                SecureField("Confirm Password", text: $confirmPassword)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)

                Button(action: {
                    registerUser()
                }) {
                    Text("Register")
                        .foregroundColor(.brandBlue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 30)

                if let error = registrationError {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }
                
                if showSuccessMessage {
                    Text("Registration Successful!")
                        .foregroundColor(.green)
                        .padding()
                }

                Spacer()

                Button(action: {
                    // Dismiss registration view to go back to login
                    authManager.isAuthenticated = false
                }) {
                    Text("Already have an account? Login")
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .padding()
            .sheet(isPresented: $showInstructionsModal) {
                InstructionsModalView() // Present modal view for instructions
            }
        }
    }

    private func registerUser() {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            registrationError = "Please fill in all fields"
            return
        }

        guard password == confirmPassword else {
            registrationError = "Passwords do not match"
            return
        }

        // Simulate registration logic with a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Simulate successful registration
            self.showSuccessMessage = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.authManager.isAuthenticated = true // Set isAuthenticated to true to navigate to HomeView
                self.showInstructionsModal = true // Show the modal with instructions after registration
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView().environmentObject(AuthManager()) 
    }
}
