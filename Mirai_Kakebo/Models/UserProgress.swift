import Foundation

struct UserProgress: Codable {
    
    var experience: Int = 0
    var level: Int = 1
    var coins: Int = 0
    
    var completedGames: Int = 0
    var completedLessons: Int = 0
    
    var completedAchievements: [String] = []
    
    // MARK: - XP del siguiente nivel
    
    var experienceForNextLevel: Int {
        level * 1000
    }
    
    // MARK: - XP dentro del nivel actual
    
    var currentLevelExperience: Int {
        experience - ((level - 1) * 1000)
    }
    
    // MARK: - Progreso del nivel
    
    var levelProgress: Double {
        
        let currentXP =
            max(
                0,
                currentLevelExperience
            )
        
        return min(
            Double(currentXP) / 1000.0,
            1.0
        )
    }
}
