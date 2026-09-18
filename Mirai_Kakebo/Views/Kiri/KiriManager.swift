import SwiftUI
import Observation

@Observable
final class KiriManager {
    
    var expression: KiriView.Expression = .happy
    
    var message: String = "¡Hola! Soy Kiri 👋"
    
    // MARK: - Home
    
    func home() {
        expression = .happy
        message = "¡Hola! ¿Qué quieres hacer hoy?"
    }
    
    // MARK: - Kakebo
    
    func kakebo() {
        expression = .saving
        message = "¡Vamos a organizar tu dinero!"
    }
    
    // MARK: - Games
    
    func games() {
        expression = .excited
        message = "¡Vamos a jugar y aprender!"
    }
    
    // MARK: - Rewards
    
    func rewards() {
        expression = .celebrating
        message = "¡Mira todas las recompensas que has conseguido!"
    }
    
    // MARK: - Profile
    
    func profile() {
        expression = .happy
        message = "¡Aquí puedes ver tu progreso!"
    }
    
    // MARK: - Actions
    
    func thinking() {
        expression = .thinking
        message = "Hmm... pensemos un poquito."
    }
    
    func correctAnswer() {
        expression = .celebrating
        message = "¡Muy bien! 🎉"
    }
    
    func incorrectAnswer() {
        expression = .sad
        message = "No pasa nada. ¡Podemos intentarlo otra vez!"
    }
    
    func shopping() {
        expression = .excited
        message = "¡Vamos de compras! Recuerda revisar tu presupuesto."
    }
    
    func saving() {
        expression = .saving
        message = "¡Ahorrar es una excelente decisión!"
    }
}
