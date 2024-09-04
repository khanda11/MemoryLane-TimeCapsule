import SwiftUI

extension TimeCapsuleListView {
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
