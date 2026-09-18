import SwiftUI

struct PurchaseReview: View {
    
    @Environment(ProgressViewModel.self)
    private var progressViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    let products: [Product]
    let total: Double
    
    @State private var purchaseCompleted = false
    @State private var advice = ""
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(
                    alignment: .leading,
                    spacing: 22
                ) {
                    
                    header
                    
                    productsList
                    
                    totalCard
                    
                    learningCard
                    
                    purchaseButton
                }
                .padding()
            }
            .background(
                MiraiColors.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Revisar compra")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            generateAdvice()
        }
        .alert(
            "¡Compra realizada! 🎉",
            isPresented: $purchaseCompleted
        ) {
            
            Button("Continuar") {
                dismiss()
            }
            
        } message: {
            
            Text(
                "Aprendiste a revisar tus compras antes de gastar tu dinero."
            )
        }
    }
    
    // MARK: - Header
    
    private var header: some View {
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            
            Text("🧠")
                .font(.system(size: 48))
            
            Text("Revisa tu compra")
                .font(MiraiFonts.title)
            
            Text(
                "Antes de comprar, piensa si cada producto es una necesidad o un deseo."
            )
            .font(MiraiFonts.body)
            .foregroundStyle(
                MiraiColors.textSecondary
            )
        }
    }
    
    // MARK: - Products
    
    private var productsList: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            Text("Productos")
                .font(MiraiFonts.headline)
            
            ForEach(products) { product in
                
                HStack(spacing: 12) {
                    
                    Text(product.emoji)
                        .font(.title2)
                    
                    VStack(
                        alignment: .leading
                    ) {
                        
                        Text(product.name)
                            .font(MiraiFonts.bodyBold)
                        
                        Text(
                            product.isNeed
                            ? "Necesidad"
                            : "Deseo"
                        )
                        .font(MiraiFonts.caption)
                        .foregroundStyle(
                            product.isNeed
                            ? MiraiColors.needs
                            : MiraiColors.warning
                        )
                    }
                    
                    Spacer()
                    
                    Text(
                        "$\(product.price, specifier: "%.0f")"
                    )
                    .font(MiraiFonts.moneySmall)
                }
                .padding()
                .background(
                    MiraiColors.card
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 16
                    )
                )
            }
        }
    }
    
    // MARK: - Total
    
    private var totalCard: some View {
        HStack {
            
            VStack(
                alignment: .leading,
                spacing: 5
            ) {
                
                Text("Total")
                    .font(MiraiFonts.body)
                
                Text(
                    "$\(total, specifier: "%.0f")"
                )
                .font(MiraiFonts.money)
                .foregroundStyle(
                    MiraiColors.money
                )
            }
            
            Spacer()
            
            Image(
                systemName: "cart.fill"
            )
            .font(.system(size: 32))
            .foregroundStyle(
                MiraiColors.orange
            )
        }
        .padding()
        .miraiCard()
    }
    
    // MARK: - AI Advice
    
    private var learningCard: some View {
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            HStack {
                
                Text("💡")
                    .font(.title2)
                
                Text("Consejo de Mirai")
                    .font(MiraiFonts.headline)
            }
            
            if advice.isEmpty {
                
                HStack {
                    ProgressView()
                    
                    Text("Mirai está pensando...")
                        .font(MiraiFonts.body)
                }
                
            } else {
                
                Text(advice)
                    .font(MiraiFonts.body)
                    .foregroundStyle(
                        MiraiColors.textSecondary
                    )
            }
        }
        .padding()
        .background(
            MiraiColors.softLavender
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20
            )
        )
    }
    
    // MARK: - Purchase Button
    
    private var purchaseButton: some View {
        Button {
            completePurchase()
        } label: {
            
            HStack {
                
                Image(
                    systemName: "checkmark.circle.fill"
                )
                
                Text("Confirmar compra")
                    .font(MiraiFonts.bodyBold)
            }
            .foregroundStyle(.white)
            .frame(
                maxWidth: .infinity
            )
            .padding()
            .background(
                MiraiColors.success
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 18
                )
            )
        }
    }
    
    // MARK: - Logic
    
    private func completePurchase() {
        
        progressViewModel.addXP(150)
        progressViewModel.addCoins(50)
        progressViewModel.completeGame()
        
        purchaseCompleted = true
    }
    
    // MARK: - AI
    
    private func generateAdvice() {
        
        advice = PurchaseAdviceService.shared.generateAdvice(
            products: products,
            total: total
        )
    }
}

#Preview {
    PurchaseReview(
        products: [
            Product(
                name: "Manzana",
                emoji: "🍎",
                price: 20,
                category: .food,
                isNeed: true
            ),
            
            Product(
                name: "Videojuego",
                emoji: "🎮",
                price: 120,
                category: .entertainment,
                isNeed: false
            )
        ],
        total: 140
    )
    .environment(
        ProgressViewModel()
    )
}
