import Foundation

struct Entry: Identifiable, Codable {
    var id: String
    var title: String
    var content: String
    var dateCreated: Date
    var unlockDate: Date
    var isLocked: Bool
    var type: EntryType // Enum for text, photo, or video
}

enum EntryType: String, Codable {
    case text
    case photo
    case video
}
