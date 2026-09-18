import Foundation
import Observation

@Observable
final class KakeboViewModel {
    
    // MARK: - Data
    
    private(set) var income: Double = 500
    private(set) var expenses: Double = 150
    
    private(set) var incomeTransactions: [KakeboTransaction] = []
    private(set) var expenseTransactions: [KakeboTransaction] = []
    
    // MARK: - Computed
    
    var balance: Double {
        income - expenses
    }
    
    // MARK: - Add Income
    
    func addIncome(
        amount: Double,
        description: String
    ) {
        guard amount > 0 else {
            return
        }
        
        income += amount
        
        incomeTransactions.append(
            KakeboTransaction(
                description: description,
                amount: amount,
                type: .income
            )
        )
    }
    
    // MARK: - Add Expense
    
    func addExpense(
        amount: Double,
        description: String
    ) {
        guard amount > 0 else {
            return
        }
        
        expenses += amount
        
        expenseTransactions.append(
            KakeboTransaction(
                description: description,
                amount: amount,
                type: .expense
            )
        )
    }
    
    // MARK: - Reset
    
    func reset() {
        income = 0
        expenses = 0
        incomeTransactions.removeAll()
        expenseTransactions.removeAll()
    }
}

// MARK: - Transaction

struct KakeboTransaction: Identifiable {
    
    let id = UUID()
    let description: String
    let amount: Double
    let type: TransactionType
}

enum TransactionType {
    case income
    case expense
}
