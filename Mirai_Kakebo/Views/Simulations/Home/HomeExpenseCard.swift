import SwiftUI

struct HomeExpenseCard: View {
    
    let expense: HomeExpense
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            
            HStack(spacing: 14) {
                
                ZStack {
                    
                    RoundedRectangle(
                        cornerRadius: 14
                    )
                    .fill(
                        isSelected
                        ? Color.blue.opacity(0.15)
                        : Color.gray.opacity(0.08)
                    )
                    .frame(
                        width: 60,
                        height: 60
                    )
                    
                    Text(expense.emoji)
                        .font(.system(size: 30))
                }
                
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    
                    Text(expense.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Text(
                        String(
                            format: "$%.0f",
                            expense.price
                        )
                    )
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                Image(
                    systemName: isSelected
                    ? "checkmark.circle.fill"
                    : "plus.circle"
                )
                .font(.title2)
                .foregroundStyle(
                    isSelected
                    ? .green
                    : .gray
                )
            }
            .padding()
            .background(.white)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 18
                )
            )
            .overlay {
                
                RoundedRectangle(
                    cornerRadius: 18
                )
                .stroke(
                    isSelected
                    ? Color.blue
                    : Color.clear,
                    lineWidth: 2
                )
            }
        }
        .buttonStyle(.plain)
    }
}


// MARK: Preview

#Preview {
    
    HomeExpenseCard(
        expense: HomeExpense(
            name: "Alimentación",
            emoji: "🍎",
            price: 300,
            isNecessary: true
        ),
        isSelected: false
    ) {
    }
    .padding()
}
