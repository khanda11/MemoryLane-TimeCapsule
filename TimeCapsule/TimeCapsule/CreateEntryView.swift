import SwiftUI

struct CreateEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var unlockDate: Date = Date()
    @Binding var entries: [TimeCapsuleEntry] // Bind the entries array to update
    @Binding var showEntryCreatedView: Bool // Binding to control navigation to EntryCreatedView

    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            TextEditor(text: $content)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .frame(height: 150)

            DatePicker("Unlock Date", selection: $unlockDate, displayedComponents: .date)
                .padding()

            Button(action: {
                addNewEntry()
            }) {
                Text("Create Entry")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding()

            Spacer()
        }
        .padding()
        .navigationTitle("New Entry")
    }

    private func addNewEntry() {
        let newEntry = TimeCapsuleEntry(
            title: title,
            content: content,
            creationDate: Date(),
            unlockDate: unlockDate
        )
        entries.append(newEntry)
        saveEntries()

        // Show EntryCreatedView instead of dismissing directly
        showEntryCreatedView = true
    }
    
    private func saveEntries() {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: "TimeCapsuleEntries")
        }
    }
}

struct CreateEntryView_Previews: PreviewProvider {
    @State static var entries: [TimeCapsuleEntry] = []
    @State static var showEntryCreatedView = false
    static var previews: some View {
        CreateEntryView(entries: $entries, showEntryCreatedView: $showEntryCreatedView)
    }
}
