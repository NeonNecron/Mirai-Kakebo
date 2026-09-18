import Foundation
import Observation

@Observable
class HomeViewModel {
    
    // MARK: - Información de bienvenida
    
    var userName: String = "Bruno"
    
    var welcomeMessage: String {
        "¡Qué bueno verte de nuevo!"
    }
    
    // MARK: - Misión diaria
    
    var dailyMissionTitle: String {
        "🛒 Compra inteligente"
    }
    
    var dailyMissionDescription: String {
        "Practica cómo elegir entre una necesidad y un deseo."
    }
    
    var dailyMissionXP: Int {
        150
    }
    
    // MARK: - Estado de la misión
    
    var dailyMissionCompleted: Bool = false
    
    func completeDailyMission() {
        dailyMissionCompleted = true
    }
}
