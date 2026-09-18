import SwiftUI

enum Category: String, CaseIterable, Identifiable, Codable {
    
    case food
    case transport
    case home
    case education
    case entertainment
    case savings
    case other
    
    var id: String {
        rawValue
    }
    
    var title: String {
        switch self {
        case .food:
            return "Comida"
        case .transport:
            return "Transporte"
        case .home:
            return "Hogar"
        case .education:
            return "Educación"
        case .entertainment:
            return "Diversión"
        case .savings:
            return "Ahorro"
        case .other:
            return "Otros"
        }
    }
    
    var emoji: String {
        switch self {
        case .food:
            return "🍎"
        case .transport:
            return "🚌"
        case .home:
            return "🏠"
        case .education:
            return "📚"
        case .entertainment:
            return "🎮"
        case .savings:
            return "🐷"
        case .other:
            return "📦"
        }
    }
    
    var color: Color {
        switch self {
        case .food:
            return MiraiColors.orange
        case .transport:
            return MiraiColors.primary
        case .home:
            return MiraiColors.matcha
        case .education:
            return MiraiColors.lavender
        case .entertainment:
            return MiraiColors.yellow
        case .savings:
            return MiraiColors.savings
        case .other:
            return MiraiColors.sakura
        }
    }
}
