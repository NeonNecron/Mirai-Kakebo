import Foundation
import Observation

@Observable
class ProgressManager {
    
    // MARK: - Progreso
    
    var progress = UserProgress()
    
    // MARK: - Agregar XP
    
    func addXP(_ amount: Int) {
        
        progress.experience += amount
        
        checkLevelUp()
    }
    
    // MARK: - Subir de nivel
    
    private func checkLevelUp() {
        
        let requiredXP = progress.level * 1000
        
        while progress.experience >= requiredXP {
            
            progress.level += 1
            
            progress.coins += 50
        }
    }
    
    // MARK: - Completar juego
    
    func completeGame(xp: Int) {
        
        progress.completedGames += 1
        
        addXP(xp)
    }
    
    // MARK: - Completar lección
    
    func completeLesson(xp: Int) {
        
        progress.completedLessons += 1
        
        addXP(xp)
    }
    
    // MARK: - Logros
    
    func checkAchievements() {
        
        for achievement in Achievement.all {
            
            if progress.experience >= achievement.requiredXP {
                
                if !progress.completedAchievements.contains(
                    achievement.title
                ) {
                    
                    progress.completedAchievements.append(
                        achievement.title
                    )
                }
            }
        }
    }
}
