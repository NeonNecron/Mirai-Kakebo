import Foundation

struct Product: Identifiable {
    
    let id = UUID()
    
    let name: String
    let emoji: String
    let price: Double
    let category: ProductCategory
    let isNeed: Bool
}

enum ProductCategory {
    case food
    case drink
    case hygiene
    case entertainment
}
