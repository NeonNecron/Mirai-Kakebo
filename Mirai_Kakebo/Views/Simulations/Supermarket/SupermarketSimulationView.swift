import SwiftUI

struct SupermarketSimulationView: View {
    
    // MARK: - Progress
    
    @Environment(ProgressViewModel.self)
    private var progressViewModel
    
    // MARK: - Game State
    
    @State private var selectedProducts: [Product] = []
    @State private var showResult = false
    @State private var showBudgetAlert = false
    
    // MARK: - Budget
    
    private let budget: Double = 300.00
    
    // MARK: - Products
    
    private let products: [Product] = [
        
        // MARK: Necesidades
        
        Product(
            name: "Pan",
            emoji: "🍞",
            price: 40.00,
            category: .food,
            isNeed: true
        ),
        
        Product(
            name: "Leche",
            emoji: "🥛",
            price: 35.00,
            category: .drink,
            isNeed: true
        ),
        
        Product(
            name: "Fruta",
            emoji: "🍎",
            price: 60.00,
            category: .food,
            isNeed: true
        ),
        
        Product(
            name: "Jabón",
            emoji: "🧼",
            price: 30.00,
            category: .hygiene,
            isNeed: true
        ),
        
        // MARK: Deseos
        
        Product(
            name: "Chocolate",
            emoji: "🍫",
            price: 30.00,
            category: .food,
            isNeed: false
        ),
        
        Product(
            name: "Galletas",
            emoji: "🍪",
            price: 25.00,
            category: .food,
            isNeed: false
        ),
        
        Product(
            name: "Jugo",
            emoji: "🧃",
            price: 35.00,
            category: .drink,
            isNeed: false
        ),
        
        Product(
            name: "Juguete",
            emoji: "🧸",
            price: 80.00,
            category: .entertainment,
            isNeed: false
        ),
        
        Product(
            name: "Videojuego",
            emoji: "🎮",
            price: 150.00,
            category: .entertainment,
            isNeed: false
        )
    ]
    
    // MARK: - Calculations
    
    private var total: Double {
        
        selectedProducts.reduce(0) {
            $0 + $1.price
        }
    }
    
    private var remaining: Double {
        budget - total
    }
    
    private var needs: [Product] {
        
        selectedProducts.filter {
            $0.isNeed
        }
    }
    
    private var wants: [Product] {
        
        selectedProducts.filter {
            !$0.isNeed
        }
    }
    
    private var allNeedsSelected: Bool {
        
        products
            .filter { $0.isNeed }
            .allSatisfy { requiredProduct in
                
                selectedProducts.contains {
                    $0.id == requiredProduct.id
                }
            }
    }
    
    // MARK: - Body
    
    var body: some View {
        
        ScrollView {
            
            VStack(
                alignment: .leading,
                spacing: 20
            ) {
                
                introduction
                
                budgetCard
                
                requiredProductsSection
                
                optionalProductsSection
                
                finishButton
            }
            .padding()
        }
        .background(
            LinearGradient(
                colors: [
                    Color.green.opacity(0.08),
                    Color.blue.opacity(0.05),
                    Color.white
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
        .navigationTitle("Supermercado")
        .navigationBarTitleDisplayMode(.inline)
        
        // MARK: Alert
        
        .alert(
            "¡Cuidado con tu presupuesto!",
            isPresented: $showBudgetAlert
        ) {
            
            Button("Entendido", role: .cancel) {
            }
            
        } message: {
            
            Text(
                "Ese producto haría que gastaras más "
                + "dinero del que tienes disponible."
            )
        }
        
        // MARK: Resultado
        
        .sheet(
            isPresented: $showResult
        ) {
            
            SupermarketResultView(
                budget: budget,
                total: total,
                remaining: remaining,
                selectedProducts: selectedProducts,
                allNeedsSelected: allNeedsSelected
            )
        }
    }
    
    // MARK: - Introduction
    
    private var introduction: some View {
        
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            
            Text("🦊 ¡Bienvenido al supermercado!")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(
                "Hoy tienes que comprar algunas cosas "
                + "importantes para la casa."
            )
            .foregroundStyle(.secondary)
            
            Text(
                "Primero compra lo necesario y después "
                + "puedes elegir algo que quieras."
            )
            .font(.subheadline)
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
    }
    
    // MARK: - Budget Card
    
    private var budgetCard: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            HStack {
                
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    
                    Text("💰 Tu dinero")
                        .font(.headline)
                    
                    Text(
                        String(
                            format: "$%.2f",
                            budget
                        )
                    )
                    .font(.title)
                    .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(
                    alignment: .trailing,
                    spacing: 4
                ) {
                    
                    Text("Disponible")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(
                        String(
                            format: "$%.2f",
                            remaining
                        )
                    )
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        remaining >= 0
                        ? .green
                        : .red
                    )
                }
            }
            
            ProgressView(
                value: min(
                    total / budget,
                    1
                )
            )
            .tint(.green)
            
            Text(
                "Gastado: "
                + String(
                    format: "$%.2f",
                    total
                )
            )
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(
            Color.green.opacity(0.12)
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
    }
    
    // MARK: - Required Products
    
    private var requiredProductsSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            HStack {
                
                Text("🎯 Necesitas comprar")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("OBLIGATORIO")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.red)
            }
            
            ForEach(
                products.filter {
                    $0.isNeed
                }
            ) { product in
                
                SimulationProductCard(
                    product: product,
                    isSelected: isSelected(product),
                    canSelect: true
                ) {
                    toggleProduct(product)
                }
            }
        }
    }
    
    // MARK: - Optional Products
    
    private var optionalProductsSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            HStack {
                
                Text("⭐ Puedes elegir")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("OPCIONAL")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.purple)
            }
            
            Text(
                "Después de comprar lo necesario, "
                + "puedes elegir algunos productos que quieras."
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            ForEach(
                products.filter {
                    !$0.isNeed
                }
            ) { product in
                
                SimulationProductCard(
                    product: product,
                    isSelected: isSelected(product),
                    canSelect: true
                ) {
                    toggleProduct(product)
                }
            }
        }
    }
    
    // MARK: - Finish Button
    
    private var finishButton: some View {
        
        Button {
            
            showResult = true
            
        } label: {
            
            HStack {
                
                Image(
                    systemName: "checkmark.circle.fill"
                )
                
                Text("Terminar compra")
                    .fontWeight(.bold)
                
                Spacer()
                
                Text(
                    String(
                        format: "$%.2f",
                        total
                    )
                )
                .fontWeight(.bold)
            }
            .foregroundStyle(.white)
            .padding()
            .frame(
                maxWidth: .infinity
            )
            .background(
                allNeedsSelected
                ? Color.green
                : Color.gray
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 18
                )
            )
        }
        .disabled(!allNeedsSelected)
    }
    
    // MARK: - Selection
    
    private func isSelected(
        _ product: Product
    ) -> Bool {
        
        selectedProducts.contains {
            $0.id == product.id
        }
    }
    
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
            
            return
        }
        
        let newTotal = total + product.price
        
        if newTotal > budget {
            
            showBudgetAlert = true
            
            return
        }
        
        selectedProducts.append(product)
    }
}


// MARK: - Preview

#Preview {
    
    NavigationStack {
        
        SupermarketSimulationView()
            .environment(
                ProgressViewModel()
            )
    }
}
