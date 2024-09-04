import SwiftUI

struct EntryDetailView: View {
    var entry: TimeCapsuleEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(entry.title)
                .font(.largeTitle)
                .padding()

            Text(entry.content)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            Text("Unlock Date: \(entry.unlockDate, style: .date)")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()

            Spacer()
        }
        .padding()
        .navigationTitle("Entry Details")
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailView(entry: TimeCapsuleEntry(title: "Sample Title", content: "Sample Content", creationDate: Date(), unlockDate: Date()))
    }
}
