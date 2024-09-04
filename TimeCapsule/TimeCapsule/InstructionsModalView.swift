import SwiftUI

struct InstructionsModalView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to MemoryLane!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)

            Text("Your time capsule for treasured moments. Here, you can create entries that will be unlocked on a future date. Unlock nostalgia and uncover past memories in an organized way, simulating your classic 'time capsule'. Follow the steps below to get started:")
                .multilineTextAlignment(.center)
                .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text("1. **Create an Entry**: Click on the 'Create New Entry' button on the dashboard to add a new memory to your capsule.")
                Text("2. **Set Unlock Date**: Choose a future date for when you want your entry to be unlocked and visible.")
                Text("3. **Manage Entries**: View all your entries on the 'Dashboard' screen. Locked entries will show a lock icon and the unlock date.")
                Text("4. **Options**: Use the 'Options' button to access more settings and manage your profile.")
            }
            .padding()
            .foregroundColor(.white)

            Spacer()

            Button(action: {
                presentationMode.wrappedValue.dismiss() // Dismiss the modal
            }) {
                Text("Got it!")
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
        .background(Color.brandBlue.edgesIgnoringSafeArea(.all))
    }
}

struct InstructionsModalView_Previews: PreviewProvider {
    static var previews: some View {
        InstructionsModalView()
            .preferredColorScheme(.dark) // Preview in dark mode for contrast
    }
}
