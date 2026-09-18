import Foundation

struct Achievement: Identifiable {
    
    let id = UUID()
    
    let title: String
    let description: String
    let emoji: String
    let requiredXP: Int
}

extension Achievement {
    
    static let all: [Achievement] = [
        
        Achievement(
            title: "Primer paso",
            description: "Completa tu primera actividad.",
            emoji: "⭐",
            requiredXP: 100
        ),
        
        Achievement(
            title: "Pequeño ahorrador",
            description: "Consigue 500 XP.",
            emoji: "🐷",
            requiredXP: 500
        ),
        
        Achievement(
            title: "Comprador inteligente",
            description: "Completa La Tienda de Mirai.",
            emoji: "🛒",
            requiredXP: 750
        ),
        
        Achievement(
            title: "Aprendiz de economía",
            description: "Consigue 1,000 XP.",
            emoji: "📚",
            requiredXP: 1000
        ),
        
        Achievement(
            title: "Maestro Kakebo",
            description: "Consigue 5,000 XP.",
            emoji: "🏆",
            requiredXP: 5000
        )
    ]
}
