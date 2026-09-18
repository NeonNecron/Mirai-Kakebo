import SwiftUI

struct SimulationProductCard: View {
    
    let product: Product
    let isSelected: Bool
    let canSelect: Bool
    let action: () -> Void
    
    var body: some View {
        
        Button {
            action()
        } label: {
            
            HStack(spacing: 15) {
                
                // MARK: Emoji
                
                ZStack {
                    
                    RoundedRectangle(
                        cornerRadius: 14
                    )
                    .fill(
                        isSelected
                        ? Color.green.opacity(0.18)
                        : Color.gray.opacity(0.10)
                    )
                    .frame(
                        width: 60,
                        height: 60
                    )
                    
                    Text(product.emoji)
                        .font(.system(size: 32))
                }
                
                // MARK: Información
                
                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {
                    
                    Text(product.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    
                    Text(
                        String(
                            format: "$%.2f",
                            product.price
                        )
                    )
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                // MARK: Estado
                
                ZStack {
                    
                    Circle()
                        .fill(
                            isSelected
                            ? Color.green
                            : Color.gray.opacity(0.15)
                        )
                        .frame(
                            width: 34,
                            height: 34
                        )
                    
                    Image(
                        systemName: isSelected
                        ? "checkmark"
                        : "plus"
                    )
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        isSelected
                        ? .white
                        : .gray
                    )
                }
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
                    ? Color.green
                    : Color.clear,
                    lineWidth: 2
                )
            }
        }
        .buttonStyle(.plain)
        .disabled(!canSelect)
    }
}


// MARK: - Preview

#Preview {
    
    SimulationProductCard(
        product: Product(
            name: "Manzana",
            emoji: "🍎",
            price: 25.00,
            category: .food,
            isNeed: true
        ),
        isSelected: false,
        canSelect: true
    ) {
    }
    .padding()
}
