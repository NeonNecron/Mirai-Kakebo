import SwiftUI

struct ProductCardView: View {
    
    let product: Product
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 10) {
            
            Text(product.emoji)
                .font(.system(size: 45))
            
            Text(product.name)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text("$\(product.price, specifier: "%.2f")")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.green)
            
            if product.isNeed {
                Text("Necesidad")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
            } else {
                Text("Deseo")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.orange)
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            isSelected
            ? Color.purple.opacity(0.15)
            : Color.white
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    isSelected ? Color.purple : Color.clear,
                    lineWidth: 3
                )
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .shadow(
            color: .black.opacity(0.06),
            radius: 8,
            y: 4
        )
    }
}

#Preview {
    ProductCardView(
        product: Product(
            name: "Manzana",
            emoji: "🍎",
            price: 15,
            category: .food,
            isNeed: true
        ),
        isSelected: true
    )
    .padding()
}
