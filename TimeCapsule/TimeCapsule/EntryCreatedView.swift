import SwiftUI

struct EntryCreatedView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Color.brandBlue.edgesIgnoringSafeArea(.all) // Background color
            
            VStack(spacing: 20) {
                Spacer()

                Text("Entry Created Successfully!")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()

                Text("Your time capsule entry has been created.")
                    .font(.body)
                    .foregroundColor(.white)
                    .padding()

                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Dismiss to go back to DashboardView
                }) {
                    Text("Back to Dashboard")
                        .foregroundColor(.brandBlue)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 5, x: 0, y: 5)
                }
                .padding(.horizontal, 30)

                Spacer()
            }
            .padding()
        }
    }
}

struct EntryCreatedView_Previews: PreviewProvider {
    static var previews: some View {
        EntryCreatedView()
    }
}
