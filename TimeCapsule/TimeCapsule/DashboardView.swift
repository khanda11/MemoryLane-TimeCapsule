import SwiftUI

struct DashboardView: View {
    @State private var entries: [TimeCapsuleEntry] = [] // Sample entries data
    @State private var showCreateEntryView = false // State to control navigation to CreateEntryView
    @State private var showEntryCreatedView = false // State to control navigation to EntryCreatedView
    @State private var showOptionsView = false // State to control navigation to OptionsView

    var body: some View {
        NavigationView {
            ZStack {
                Color.brandBlue.edgesIgnoringSafeArea(.all) // Background color

                ScrollView { // Enable scrolling
                    VStack(spacing: 20) {
                        Text("Dashboard")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()

                        // Display a list of entries
                        VStack(spacing: 10) {
                            ForEach(entries) { entry in
                                if entry.unlockDate <= Date() {
                                    // Unlocked entry, show NavigationLink
                                    NavigationLink(destination: EntryDetailView(entry: entry)) {
                                        VStack(alignment: .leading) {
                                            Text(entry.title)
                                                .font(.headline)
                                                .foregroundColor(.brandBlue) // Set text color to match brand
                                            Text("Unlocked on \(entry.unlockDate, style: .date)")
                                                .font(.subheadline)
                                                .foregroundColor(.brandBlue.opacity(0.8)) // Use brand color with opacity
                                        }
                                        .padding()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                                    }
                                } else {
                                    HStack {
                                        Image(systemName: "lock.fill")
                                            .foregroundColor(.white)
                                        VStack(alignment: .leading) {
                                            Text(entry.title)
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text("Unlocks on \(entry.unlockDate, style: .date)")
                                                .font(.subheadline)
                                                .foregroundColor(.white.opacity(0.8))
                                        }
                                    }
                                    .padding()
                                    .background(Color.white.opacity(0.2)) // Set lighter background color for locked entries
                                    .cornerRadius(10)
                                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                                }
                            }
                        }
                        .padding(.horizontal)

                        Spacer()

                        // Navigation link to OptionsView
                        NavigationLink(destination: OptionsView(showCreateEntryView: $showCreateEntryView), isActive: $showOptionsView) {
                            Button(action: {
                                showOptionsView = true
                            }) {
                                Text("Options")
                                    .font(.headline)
                                    .foregroundColor(.brandBlue)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(color: .gray, radius: 5, x: 0, y: 5)
                            }
                        }
                        .padding(.horizontal, 30)

                        // Navigation link to CreateEntryView
                        NavigationLink(destination: CreateEntryView(entries: $entries, showEntryCreatedView: $showEntryCreatedView), isActive: $showCreateEntryView) {
                            EmptyView()
                        }

                        // Navigation link to EntryCreatedView
                        NavigationLink(destination: EntryCreatedView(), isActive: $showEntryCreatedView) {
                            EmptyView()
                        }
                    }
                    .padding()
                }
                .onAppear(perform: loadEntries)
            }
            .navigationBarTitleDisplayMode(.inline) // Make the title inline to reduce space usage
        }
    }

    private func deleteEntry(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
        saveEntries()
    }

    private func saveEntries() {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: "TimeCapsuleEntries")
        }
    }

    private func loadEntries() {
        if let savedEntries = UserDefaults.standard.object(forKey: "TimeCapsuleEntries") as? Data {
            if let decodedEntries = try? JSONDecoder().decode([TimeCapsuleEntry].self, from: savedEntries) {
                entries = decodedEntries
            }
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .preferredColorScheme(.dark) // Preview in dark mode for better contrast
    }
}
