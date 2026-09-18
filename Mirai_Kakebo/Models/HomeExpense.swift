import Foundation

struct HomeExpense: Identifiable {
    
    let id = UUID()
    
    let name: String
    let emoji: String
    let price: Double
    let isNecessary: Bool
}
