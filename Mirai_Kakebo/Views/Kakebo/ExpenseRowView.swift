import SwiftUI

struct ExpenseRowView: View {
    
    let expense: Expense
    
    var body: some View {
        HStack(spacing: 14) {
            
            CategoryIcon(
                category: expense.category,
                size: 50
            )
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                
                Text(expense.name)
                    .font(MiraiFonts.bodyMedium)
                
                HStack(spacing: 5) {
                    
                    Text(expense.category.title)
                    
                    Text("•")
                    
                    Text(
                        expense.date,
                        style: .date
                    )
                }
                .font(MiraiFonts.caption)
                .foregroundStyle(
                    MiraiColors.textSecondary
                )
            }
            
            Spacer()
            
            VStack(
                alignment: .trailing,
                spacing: 4
            ) {
                
                Text(
                    "-$\(expense.amount, specifier: "%.2f")"
                )
                .font(MiraiFonts.moneySmall)
                .foregroundStyle(
                    MiraiColors.textPrimary
                )
                
                Text(
                    expense.isNecessary
                    ? "Necesidad"
                    : "Deseo"
                )
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundStyle(
                    expense.isNecessary
                    ? MiraiColors.matcha
                    : MiraiColors.sakura
                )
            }
        }
        .padding(.vertical, 6)
    }
}
