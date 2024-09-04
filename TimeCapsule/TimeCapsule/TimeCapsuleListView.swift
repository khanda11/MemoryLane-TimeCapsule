import SwiftUI

struct TimeCapsuleListView: View {
    @State var entries: [TimeCapsuleEntry] = []
    @State private var showCreateEntryView: Bool = false
    @State private var showEntryCreatedView: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.brandBlue.edgesIgnoringSafeArea(.all) // Background color

                VStack {
                    ScrollView {
                        VStack(spacing: 10) {
                            ForEach(entries) { entry in
                                HStack {
                                    if entry.unlockDate > Date() {
                                        // Locked Entry
                                        Image(systemName: "lock.fill")
                                            .foregroundColor(.white)
                                        VStack(alignment: .leading) {
                                            Text(entry.title)
                                                .font(.headline)
                                                .foregroundColor(.white) // Update text color
                                            Text("Unlocks on \(entry.unlockDate, style: .date)")
                                                .font(.subheadline)
                                                .foregroundColor(.white.opacity(0.8))
                                            Text("Created on \(entry.creationDate, style: .date)")
                                                .font(.footnote)
                                                .foregroundColor(.white.opacity(0.8))
                                        }
                                    } else {
                                        // Unlocked Entry
                                        NavigationLink(destination: EntryDetailView(entry: entry)) {
                                            VStack(alignment: .leading) {
                                                Text(entry.title)
                                                    .font(.headline)
                                                    .foregroundColor(.brandBlue) // Update text color
                                                Text("Unlocked on \(entry.unlockDate, style: .date)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.brandBlue.opacity(0.8))
                                                Text("Created on \(entry.creationDate, style: .date)")
                                                    .font(.footnote)
                                                    .foregroundColor(.brandBlue.opacity(0.8))
                                            }
                                            .padding()
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                                        }
                                    }
                                }
                                .padding()
                                .background(Color.brandBlue.opacity(0.8))
                                .cornerRadius(10)
                                .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 5)
                            }
                            .onDelete(perform: deleteEntry)
                        }
                        .padding(.horizontal, 20)
                    }
                    .navigationTitle("Time Capsule")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                showCreateEntryView = true
                            }) {
                                Image(systemName: "plus")
                                    .foregroundColor(.white) // Update button color
                            }
                        }
                    }

                    // NavigationLink to CreateEntryView
                    NavigationLink(
                        destination: CreateEntryView(entries: $entries, showEntryCreatedView: $showEntryCreatedView),
                        isActive: $showCreateEntryView
                    ) {
                        EmptyView()
                    }

                    // NavigationLink to EntryCreatedView
                    NavigationLink(
                        destination: EntryCreatedView(),
                        isActive: $showEntryCreatedView
                    ) {
                        EmptyView()
                    }
                }
                .onAppear(perform: loadEntries)
            }
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

struct TimeCapsuleListView_Previews: PreviewProvider {
    static var previews: some View {
        TimeCapsuleListView()
            .preferredColorScheme(.dark) // Preview in dark mode for contrast
    }
}
