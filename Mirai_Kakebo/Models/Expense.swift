import Foundation

struct Expense: Identifiable, Codable {
    
    let id: UUID
    var name: String
    var amount: Double
    var category: Category
    var date: Date
    var note: String
    var isNecessary: Bool
    
    init(
        id: UUID = UUID(),
        name: String,
        amount: Double,
        category: Category,
        date: Date = Date(),
        note: String = "",
        isNecessary: Bool = true
    ) {
        self.id = id
        self.name = name
        self.amount = amount
        self.category = category
        self.date = date
        self.note = note
        self.isNecessary = isNecessary
    }
}
