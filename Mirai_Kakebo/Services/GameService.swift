import Foundation

final class GameService {
    
    static let shared = GameService()
    
    private init() {}
    
    // MARK: - Available Games
    
    var games: [Game] {
        [
            Game(
                title: "La Tienda de Mirai",
                description: "Aprende a comprar y comparar diferentes productos.",
                emoji: "🛒",
                xpReward: 150,
                difficulty: "Fácil",
                category: "Compras",
                instructions: "Observa los productos, compara sus precios y decide cuáles necesitas comprar.",
                duration: 5
            ),
            
            Game(
                title: "Reto del Ahorro",
                description: "Aprende a guardar dinero y tomar mejores decisiones.",
                emoji: "🐷",
                xpReward: 100,
                difficulty: "Fácil",
                category: "Ahorro",
                instructions: "Responde las preguntas y descubre cómo puedes cuidar mejor tu dinero.",
                duration: 5
            ),
            
            Game(
                title: "Supermercado de Mirai",
                description: "Administra un presupuesto y compra lo necesario.",
                emoji: "🛒",
                xpReward: 100,
                difficulty: "Medio",
                category: "Necesidades",
                instructions: "Tienes un presupuesto limitado. Primero compra lo que necesitas.",
                duration: 8
            ),
            
            Game(
                title: "La Casa de Mirai",
                description: "Administra el dinero de una casa.",
                emoji: "🏠",
                xpReward: 150,
                difficulty: "Medio",
                category: "Hogar",
                instructions: "Ayuda a Mirai a cubrir las necesidades del hogar y guardar una parte del dinero.",
                duration: 10
            )
        ]
    }
    
    func game(
        withID id: UUID
    ) -> Game? {
        games.first {
            $0.id == id
        }
    }
}
