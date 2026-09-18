import Foundation

struct Game: Identifiable, Codable {
    
    let id: UUID
    let title: String
    let description: String
    let emoji: String
    let xpReward: Int
    let difficulty: String
    let category: String
    let instructions: String
    let duration: Int
    let isLocked: Bool
    
    init(
        id: UUID = UUID(),
        title: String,
        description: String,
        emoji: String,
        xpReward: Int,
        difficulty: String,
        category: String,
        instructions: String,
        duration: Int = 5,
        isLocked: Bool = false
    ) {
        self.id = id
        self.title = title
        self.description = description
        self.emoji = emoji
        self.xpReward = xpReward
        self.difficulty = difficulty
        self.category = category
        self.instructions = instructions
        self.duration = duration
        self.isLocked = isLocked
    }
}
