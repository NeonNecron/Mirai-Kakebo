import SwiftUI

struct HomeSimulationView: View {
    
    @Environment(ProgressViewModel.self)
    private var progressViewModel
    
    @State private var selectedExpenses: [HomeExpense] = []
    
    @State private var showEmergency = false
    @State private var showResult = false
    
    private let budget: Double = 1000
    
    private let expenses: [HomeExpense] = [
        
        HomeExpense(
            name: "Alimentación",
            emoji: "🍎",
            price: 300,
            isNecessary: true
        ),
        
        HomeExpense(
            name: "Higiene",
            emoji: "🧼",
            price: 100,
            isNecessary: true
        ),
        
        HomeExpense(
            name: "Transporte",
            emoji: "🚌",
            price: 100,
            isNecessary: true
        ),
        
        HomeExpense(
            name: "Electricidad",
            emoji: "💡",
            price: 150,
            isNecessary: true
        ),
        
        HomeExpense(
            name: "Videojuego",
            emoji: "🎮",
            price: 150,
            isNecessary: false
        ),
        
        HomeExpense(
            name: "Helado",
            emoji: "🍦",
            price: 50,
            isNecessary: false
        ),
        
        HomeExpense(
            name: "Película",
            emoji: "🎬",
            price: 100,
            isNecessary: false
        ),
        
        HomeExpense(
            name: "Juguete",
            emoji: "🧸",
            price: 120,
            isNecessary: false
        )
    ]
    
    private var totalSpent: Double {
        
        selectedExpenses.reduce(0) {
            $0 + $1.price
        }
    }
    
    private var remainingMoney: Double {
        budget - totalSpent
    }
    
    private var necessaryExpenses: [HomeExpense] {
        
        selectedExpenses.filter {
            $0.isNecessary
        }
    }
    
    private var optionalExpenses: [HomeExpense] {
        
        selectedExpenses.filter {
            !$0.isNecessary
        }
    }
    
    private var allNecessarySelected: Bool {
        
        expenses
            .filter {
                $0.isNecessary
            }
            .allSatisfy { expense in
                
                selectedExpenses.contains {
                    $0.id == expense.id
                }
            }
    }
    
    var body: some View {
        
        ScrollView {
            
            VStack(
                alignment: .leading,
                spacing: 20
            ) {
                
                header
                
                budgetCard
                
                necessarySection
                
                optionalSection
                
                finishButton
            }
            .padding()
        }
        .background(
            LinearGradient(
                colors: [
                    Color.blue.opacity(0.08),
                    Color.green.opacity(0.06),
                    Color.white
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
        .navigationTitle("Casa de Mirai")
        .navigationBarTitleDisplayMode(.inline)
        
        .sheet(
            isPresented: $showEmergency
        ) {
            
            emergencyView
        }
        
        .sheet(
            isPresented: $showResult
        ) {
            
            HomeSimulationResultView(
                budget: budget,
                totalSpent: totalSpent,
                remainingMoney: remainingMoney,
                necessaryExpenses: necessaryExpenses,
                optionalExpenses: optionalExpenses
            )
        }
    }
    
    
    // MARK: Header
    
    private var header: some View {
        
        VStack(
            alignment: .leading,
            spacing: 10
        ) {
            
            Text("🏠 La Casa de Mirai")
                .font(.title)
                .fontWeight(.bold)
            
            Text(
                "Administra el dinero de la casa. "
                + "Primero cubre las necesidades y "
                + "después decide qué hacer con el resto."
            )
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
    }
    
    
    // MARK: Budget
    
    private var budgetCard: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            HStack {
                
                VStack(
                    alignment: .leading
                ) {
                    
                    Text("💰 Presupuesto")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(
                        String(
                            format: "$%.0f",
                            budget
                        )
                    )
                    .font(.title)
                    .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack(
                    alignment: .trailing
                ) {
                    
                    Text("Disponible")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(
                        String(
                            format: "$%.0f",
                            remainingMoney
                        )
                    )
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        remainingMoney >= 0
                        ? .green
                        : .red
                    )
                }
            }
            
            ProgressView(
                value: min(
                    totalSpent / budget,
                    1
                )
            )
            .tint(.blue)
        }
        .padding()
        .background(
            Color.blue.opacity(0.10)
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
    }
    
    
    // MARK: Necessary
    
    private var necessarySection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            Text("🎯 Gastos necesarios")
                .font(.title3)
                .fontWeight(.bold)
            
            Text(
                "Estos gastos son importantes para mantener "
                + "la casa funcionando."
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            ForEach(
                expenses.filter {
                    $0.isNecessary
                }
            ) { expense in
                
                HomeExpenseCard(
                    expense: expense,
                    isSelected: isSelected(expense)
                ) {
                    toggleExpense(expense)
                }
            }
        }
    }
    
    
    // MARK: Optional
    
    private var optionalSection: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            Text("⭐ Deseos")
                .font(.title3)
                .fontWeight(.bold)
            
            Text(
                "Puedes elegir alguno, pero recuerda "
                + "que también puedes ahorrar."
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            
            ForEach(
                expenses.filter {
                    !$0.isNecessary
                }
            ) { expense in
                
                HomeExpenseCard(
                    expense: expense,
                    isSelected: isSelected(expense)
                ) {
                    toggleExpense(expense)
                }
            }
        }
    }
    
    
    // MARK: Finish
    
    private var finishButton: some View {
        
        Button {
            
            if remainingMoney >= 100 {
                
                showEmergency = true
                
            } else {
                
                showResult = true
            }
            
        } label: {
            
            Text("Continuar")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(
                    maxWidth: .infinity
                )
                .padding()
                .background(
                    allNecessarySelected
                    ? Color.blue
                    : Color.gray
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 18
                    )
                )
        }
        .disabled(!allNecessarySelected)
    }
    
    
    // MARK: Emergency
    
    private var emergencyView: some View {
        
        VStack(
            spacing: 20
        ) {
            
            Spacer()
            
            Text("🚨")
                .font(.system(size: 70))
            
            Text("¡Algo inesperado ocurrió!")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(
                "Necesitas $100 para resolver "
                + "un problema importante en casa."
            )
            .multilineTextAlignment(.center)
            .foregroundStyle(.secondary)
            
            Text(
                "Tienes disponibles:"
            )
            .font(.headline)
            
            Text(
                String(
                    format: "$%.0f",
                    remainingMoney
                )
            )
            .font(.system(size: 40))
            .fontWeight(.bold)
            .foregroundStyle(.green)
            
            Text(
                "Tienes suficiente dinero para afrontar "
                + "esta emergencia. ¡Guardar dinero puede "
                + "darte tranquilidad cuando sucede algo inesperado!"
            )
            .multilineTextAlignment(.center)
            
            Spacer()
            
            Button {
                
                showEmergency = false
                showResult = true
                
            } label: {
                
                Text("Continuar")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(
                        maxWidth: .infinity
                    )
                    .padding()
                    .background(.green)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 18
                        )
                    )
            }
        }
        .padding(30)
    }
    
    
    // MARK: Helpers
    
    private func isSelected(
        _ expense: HomeExpense
    ) -> Bool {
        
        selectedExpenses.contains {
            $0.id == expense.id
        }
    }
    
    
    private func toggleExpense(
        _ expense: HomeExpense
    ) {
        
        if let index = selectedExpenses.firstIndex(
            where: {
                $0.id == expense.id
            }
        ) {
            
            selectedExpenses.remove(
                at: index
            )
            
            return
        }
        
        let newTotal =
            totalSpent + expense.price
        
        if newTotal <= budget {
            
            selectedExpenses.append(
                expense
            )
        }
    }
}


// MARK: Preview

#Preview {
    
    NavigationStack {
        
        HomeSimulationView()
            .environment(
                ProgressViewModel()
            )
    }
}
