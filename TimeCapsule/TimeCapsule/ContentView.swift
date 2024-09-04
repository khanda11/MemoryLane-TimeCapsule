import SwiftUI

struct ContentView: View {
    @State private var entries: [TimeCapsuleEntry] = [] 

    var body: some View {
        NavigationView {
            List(entries) { entry in
                NavigationLink(destination: EntryDetailView(entry: entry)) {
                    VStack(alignment: .leading) {
                        Text(entry.title)
                            .font(.headline)
                        Text(entry.unlockDate, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Time Capsule")
            .onAppear {
                fetchEntries()
            }
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Navigate to CreateEntryView
                    }) {
                        Image(systemName: "plus")
                    }
                }
                #else
                ToolbarItem {
                    Button(action: {
                        // Navigate to CreateEntryView
                    }) {
                        Image(systemName: "plus")
                    }
                }
                #endif
            }
        }
    }

    private func fetchEntries() {
        NetworkManager.shared.fetchEntries { result in
            switch result {
            case .success(let fetchedEntries):
                // Convert each Entry to TimeCapsuleEntry using the initializer
                self.entries = fetchedEntries.map(TimeCapsuleEntry.init)
            case .failure(let error):
                print("Error fetching entries: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
