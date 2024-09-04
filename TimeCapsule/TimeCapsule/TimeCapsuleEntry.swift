import Foundation

struct TimeCapsuleEntry: Identifiable, Codable {
    var id: UUID // Note that using `var id = UUID()` might cause the issue; change it to `var id: UUID` instead.
    var title: String
    var content: String
    var creationDate: Date
    var unlockDate: Date

    init(id: UUID = UUID(), title: String, content: String, creationDate: Date, unlockDate: Date) {
        self.id = id
        self.title = title
        self.content = content
        self.creationDate = creationDate
        self.unlockDate = unlockDate
    }

    // Initializer to convert from Entry
    init(from entry: Entry) {
        self.id = UUID() 
        self.title = entry.title
        self.content = entry.content
        self.creationDate = entry.dateCreated
        self.unlockDate = entry.unlockDate
    }
}
