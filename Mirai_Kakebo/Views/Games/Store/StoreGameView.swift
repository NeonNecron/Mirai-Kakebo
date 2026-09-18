import SwiftUI

struct StoreGameView: View {
    
    @Environment(ProgressViewModel.self)
    private var progressViewModel
    
    @State private var selectedProducts: [Product] = []
    @State private var showingReview = false
    
    private let products: [Product] = [
        
        Product(
            name: "Manzana",
            emoji: "🍎",
            price: 20,
            category: .food,
            isNeed: true
        ),
        
        Product(
            name: "Pan",
            emoji: "🍞",
            price: 30,
            category: .food,
            isNeed: true
        ),
        
        Product(
            name: "Agua",
            emoji: "💧",
            price: 15,
            category: .drink,
            isNeed: true
        ),
        
        Product(
            name: "Jabón",
            emoji: "🧼",
            price: 25,
            category: .hygiene,
            isNeed: true
        ),
        
        Product(
            name: "Refresco",
            emoji: "🥤",
            price: 25,
            category: .drink,
            isNeed: false
        ),
        
        Product(
            name: "Chocolate",
            emoji: "🍫",
            price: 35,
            category: .food,
            isNeed: false
        ),
        
        Product(
            name: "Videojuego",
            emoji: "🎮",
            price: 120,
            category: .entertainment,
            isNeed: false
        ),
        
        Product(
            name: "Pelota",
            emoji: "⚽",
            price: 80,
            category: .entertainment,
            isNeed: false
        )
    ]
    
    private var total: Double {
        selectedProducts.reduce(0) {
            $0 + $1.price
        }
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack(
                alignment: .leading,
                spacing: 22
            ) {
                
                header
                
                budgetCard
                
                productsSection
                
                if !selectedProducts.isEmpty {
                    cartSummary
                }
            }
            .padding()
        }
        .background(
            LinearGradient(
                colors: [
                    MiraiColors.softMatcha,
                    MiraiColors.softLavender,
                    MiraiColors.background
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
        .navigationTitle("La Tienda de Mirai")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(
            isPresented: $showingReview
        ) {
            PurchaseReview(
                products: selectedProducts,
                total: total
            )
            .environment(progressViewModel)
        }
    }
    
    // MARK: - Header
    
    private var header: some View {
        HStack {
            
            Text("🛒")
                .font(.system(size: 42))
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                
                Text("La Tienda de Mirai")
                    .font(MiraiFonts.title)
                
                Text(
                    "Aprende a diferenciar necesidades y deseos."
                )
                .font(MiraiFonts.caption)
                .foregroundStyle(
                    MiraiColors.textSecondary
                )
            }
            
            Spacer()
        }
    }
    
    // MARK: - Budget
    
    private var budgetCard: some View {
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            
            HStack {
                
                Image(
                    systemName: "banknote.fill"
                )
                .foregroundStyle(
                    MiraiColors.money
                )
                
                Text("Presupuesto")
                    .font(MiraiFonts.bodyBold)
                
                Spacer()
                
                Text("$300")
                    .font(MiraiFonts.moneySmall)
                    .foregroundStyle(
                        MiraiColors.money
                    )
            }
            
            Text(
                "Piensa antes de comprar. ¿Realmente lo necesitas?"
            )
            .font(MiraiFonts.caption)
            .foregroundStyle(
                MiraiColors.textSecondary
            )
        }
        .padding()
        .miraiCard()
    }
    
    // MARK: - Products
    
    private var productsSection: some View {
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            
            Text("Productos")
                .font(MiraiFonts.headline)
            
            ForEach(products) { product in
                productCard(product)
            }
        }
    }
    
    private func productCard(
        _ product: Product
    ) -> some View {
        
        Button {
            toggleProduct(product)
        } label: {
            
            HStack(spacing: 14) {
                
                ZStack {
                    
                    RoundedRectangle(
                        cornerRadius: 16
                    )
                    .fill(
                        product.isNeed
                        ? MiraiColors.softMatcha
                        : MiraiColors.softYellow
                    )
                    .frame(
                        width: 58,
                        height: 58
                    )
                    
                    Text(product.emoji)
                        .font(.system(size: 30))
                }
                
                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {
                    
                    Text(product.name)
                        .font(MiraiFonts.bodyBold)
                        .foregroundStyle(
                            MiraiColors.textPrimary
                        )
                    
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
                
                VStack(
                    alignment: .trailing,
                    spacing: 6
                ) {
                    
                    Text(
                        "$\(product.price, specifier: "%.0f")"
                    )
                    .font(MiraiFonts.moneySmall)
                    .foregroundStyle(
                        MiraiColors.money
                    )
                    
                    if selectedProducts.contains(
                        where: {
                            $0.id == product.id
                        }
                    ) {
                        Image(
                            systemName: "checkmark.circle.fill"
                        )
                        .foregroundStyle(
                            MiraiColors.success
                        )
                    }
                }
            }
            .padding()
            .background(
                MiraiColors.card
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 20
                )
            )
        }
        .buttonStyle(.plain)
    }
    
    // MARK: - Cart
    
    private var cartSummary: some View {
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            
            HStack {
                
                Text("🧺")
                    .font(.title2)
                
                Text("Tu compra")
                    .font(MiraiFonts.headline)
                
                Spacer()
                
                Text(
                    "$\(total, specifier: "%.0f")"
                )
                .font(MiraiFonts.moneySmall)
                .foregroundStyle(
                    MiraiColors.money
                )
            }
            
            Text(
                "\(selectedProducts.count) producto(s) seleccionado(s)"
            )
            .font(MiraiFonts.caption)
            .foregroundStyle(
                MiraiColors.textSecondary
            )
            
            Button {
                showingReview = true
            } label: {
                
                Text("Revisar compra")
                    .font(MiraiFonts.bodyBold)
                    .foregroundStyle(.white)
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding()
                    .background(
                        MiraiColors.primary
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 16
                        )
                    )
            }
        }
        .padding()
        .miraiCard()
    }
    
    // MARK: - Logic
    
    private func toggleProduct(
        _ product: Product
    ) {
        
        if let index = selectedProducts.firstIndex(
            where: {
                $0.id == product.id
            }
        ) {
            
            selectedProducts.remove(
                at: index
            )
            
        } else {
            
            selectedProducts.append(
                product
            )
        }
    }
}

#Preview {
    NavigationStack {
        StoreGameView()
            .environment(
                ProgressViewModel()
            )
    }
}
