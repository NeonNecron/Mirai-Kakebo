import Foundation
import Observation

@Observable
final class ProgressViewModel {
    
    // MARK: - User Progress
    
    private(set) var progress = UserProgress()
    
    // MARK: - Convenience Properties
    
    var experience: Int {
        progress.experience
    }
    
    var level: Int {
        progress.level
    }
    
    var coins: Int {
        progress.coins
    }
    
    var completedGames: Int {
        progress.completedGames
    }
    
    var completedLessons: Int {
        progress.completedLessons
    }
    
    var completedAchievements: [String] {
        progress.completedAchievements
    }
    
    // XP total necesario para subir al siguiente nivel
    var experienceForNextLevel: Int {
        progress.experienceForNextLevel
    }
    
    // Progreso del nivel actual
    var levelProgress: Double {
        progress.levelProgress
    }
    
    // XP obtenido dentro del nivel actual
    var currentLevelExperience: Int {
        progress.experience - ((progress.level - 1) * 1000)
    }
    
    // XP que falta para subir de nivel
    var experienceRemaining: Int {
        max(
            experienceForNextLevel - experience,
            0
        )
    }
    
    // MARK: - Add XP
    
    func addXP(_ amount: Int) {
        
        guard amount > 0 else {
            return
        }
        
        progress.experience += amount
        
        updateLevel()
        
        saveProgress()
    }
    
    // MARK: - Add Coins
    
    func addCoins(_ amount: Int) {
        
        guard amount > 0 else {
            return
        }
        
        progress.coins += amount
        
        saveProgress()
    }
    
    // MARK: - Spend Coins
    
    @discardableResult
    func spendCoins(_ amount: Int) -> Bool {
        
        guard amount > 0 else {
            return false
        }
        
        guard progress.coins >= amount else {
            return false
        }
        
        progress.coins -= amount
        
        saveProgress()
        
        return true
    }
    
    // MARK: - Complete Game
    
    func completeGame() {
        
        progress.completedGames += 1
        
        saveProgress()
    }
    
    // MARK: - Complete Lesson
    
    func completeLesson() {
        
        progress.completedLessons += 1
        
        saveProgress()
    }
    
    // MARK: - Achievements
    
    func unlockAchievement(_ achievement: Achievement) {
        
        guard !progress.completedAchievements.contains(achievement.title) else {
            return
        }
        
        guard progress.experience >= achievement.requiredXP else {
            return
        }
        
        progress.completedAchievements.append(
            achievement.title
        )
        
        saveProgress()
    }
    
    // MARK: - Level
    
    private func updateLevel() {
        
        let calculatedLevel =
            max(
                1,
                (progress.experience / 1000) + 1
            )
        
        progress.level = calculatedLevel
    }
    
    // MARK: - Reset
    
    func resetProgress() {
        
        progress = UserProgress()
        
        saveProgress()
    }
    
    // MARK: - Persistence
    
    private let progressKey = "mirai.user.progress"
    
    init() {
        loadProgress()
    }
    
    private func saveProgress() {
        
        do {
            
            let data = try JSONEncoder().encode(
                ProgressData(
                    experience: progress.experience,
                    level: progress.level,
                    coins: progress.coins,
                    completedGames: progress.completedGames,
                    completedLessons: progress.completedLessons,
                    completedAchievements: progress.completedAchievements
                )
            )
            
            UserDefaults.standard.set(
                data,
                forKey: progressKey
            )
            
        } catch {
            
            print(
                "Error guardando progreso: \(error)"
            )
        }
    }
    
    private func loadProgress() {
        
        guard let data =
                UserDefaults.standard.data(
                    forKey: progressKey
                )
        else {
            return
        }
        
        do {
            
            let saved =
                try JSONDecoder().decode(
                    ProgressData.self,
                    from: data
                )
            
            progress.experience =
                saved.experience
            
            progress.level =
                saved.level
            
            progress.coins =
                saved.coins
            
            progress.completedGames =
                saved.completedGames
            
            progress.completedLessons =
                saved.completedLessons
            
            progress.completedAchievements =
                saved.completedAchievements
            
        } catch {
            
            print(
                "Error cargando progreso: \(error)"
            )
        }
    }
}

// MARK: - Persistence Model

private struct ProgressData: Codable {
    
    let experience: Int
    let level: Int
    let coins: Int
    let completedGames: Int
    let completedLessons: Int
    let completedAchievements: [String]
}
