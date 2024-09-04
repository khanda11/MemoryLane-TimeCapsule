import SwiftUI

struct OptionsView: View {
    @Binding var showCreateEntryView: Bool // Binding to control navigation to CreateEntryView
    @State private var showFullListView = false // State to control navigation to TimeCapsuleListView

    var body: some View {
        VStack(spacing: 20) {
            Text("Options")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()

            Button(action: {
                showCreateEntryView = true
            }) {
                Text("Create New Entry")
                    .font(.headline)
                    .foregroundColor(.brandBlue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal, 30)

            Button(action: {
                showFullListView = true
            }) {
                Text("View Full List of Entries")
                    .font(.headline)
                    .foregroundColor(.brandBlue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
            }
            .padding(.horizontal, 30)

            Spacer()
        }
        .padding()
        .background(Color.brandBlue.edgesIgnoringSafeArea(.all))
        .navigationBarTitle("Options", displayMode: .inline)

    
        NavigationLink(destination: TimeCapsuleListView(), isActive: $showFullListView) {
            EmptyView()
        }
    }
}

struct OptionsView_Previews: PreviewProvider {
    @State static var showCreateEntryView = false

    static var previews: some View {
        OptionsView(showCreateEntryView: $showCreateEntryView)
            .environment(\.colorScheme, .dark) // Preview in dark mode for contrast
    }
}
