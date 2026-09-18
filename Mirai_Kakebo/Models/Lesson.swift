import Foundation

struct Lesson: Identifiable, Codable {
    
    let id: UUID
    let title: String
    let description: String
    let content: String
    let emoji: String
    let duration: Int
    let xpReward: Int
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        content: String,
        emoji: String,
        duration: Int,
        xpReward: Int
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.content = content
        self.emoji = emoji
        self.duration = duration
        self.xpReward = xpReward
    }
}
