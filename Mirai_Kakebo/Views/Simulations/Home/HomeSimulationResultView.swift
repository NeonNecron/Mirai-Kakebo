import SwiftUI

struct HomeSimulationResultView: View {
    
    // MARK: - Environment
    
    @Environment(ProgressViewModel.self)
    private var progressViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    // MARK: - Data
    
    let budget: Double
    let totalSpent: Double
    let remainingMoney: Double
    
    let necessaryExpenses: [HomeExpense]
    let optionalExpenses: [HomeExpense]
    
    // MARK: - State
    
    @State private var progressRegistered = false
    
    
    // MARK: - Calculated Values
    
    private var necessaryCount: Int {
        necessaryExpenses.count
    }
    
    private var optionalCount: Int {
        optionalExpenses.count
    }
    
    private var savingsPercentage: Double {
        
        guard budget > 0 else {
            return 0
        }
        
        return (remainingMoney / budget) * 100
    }
    
    private var managementScore: Int {
        
        var score = 0
        
        // Cubrió todas las necesidades.
        if necessaryCount >= 4 {
            score += 50
        }
        
        // Ahorró dinero.
        if remainingMoney >= 200 {
            score += 30
        } else if remainingMoney > 0 {
            score += 20
        }
        
        // Compró pocos deseos.
        if optionalCount == 0 {
            score += 20
        } else if optionalCount <= 2 {
            score += 15
        } else {
            score += 5
        }
        
        return min(score, 100)
    }
    
    private var earnedXP: Int {
        
        switch managementScore {
            
        case 90...100:
            return 150
            
        case 70..<90:
            return 125
            
        case 50..<70:
            return 100
            
        default:
            return 75
        }
    }
    
    private var resultEmoji: String {
        
        switch managementScore {
            
        case 90...100:
            return "🌟"
            
        case 70..<90:
            return "😊"
            
        case 50..<70:
            return "🦊"
            
        default:
            return "💡"
        }
    }
    
    private var resultTitle: String {
        
        switch managementScore {
            
        case 90...100:
            return "¡Excelente administrador!"
            
        case 70..<90:
            return "¡Muy buen trabajo!"
            
        case 50..<70:
            return "¡Vas aprendiendo!"
            
        default:
            return "¡Buen intento!"
        }
    }
    
    private var resultMessage: String {
        
        switch managementScore {
            
        case 90...100:
            return """
            Supiste cubrir las necesidades de la casa
            y conservar una buena cantidad de dinero.
            """
            
        case 70..<90:
            return """
            Tomaste buenas decisiones. Recuerda que
            ahorrar también es importante para el futuro.
            """
            
        case 50..<70:
            return """
            Ya estás aprendiendo a distinguir entre
            lo que necesitas y lo que quieres.
            """
            
        default:
            return """
            No pasa nada. Administrar dinero requiere
            práctica. ¡Puedes intentarlo nuevamente!
            """
        }
    }
    
    
    // MARK: - Body
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(
                    spacing: 22
                ) {
                    
                    resultHeader
                    
                    scoreCard
                    
                    moneySummary
                    
                    decisionsSummary
                    
                    emergencyCard
                    
                    learningCard
                    
                    rewardCard
                    
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
            .navigationTitle("Resultado")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            registerProgress()
        }
    }
    
    
    // MARK: - Header
    
    private var resultHeader: some View {
        
        VStack(
            spacing: 10
        ) {
            
            Text(resultEmoji)
                .font(.system(size: 70))
            
            Text(resultTitle)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(resultMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 10)
    }
    
    
    // MARK: - Score
    
    private var scoreCard: some View {
        
        VStack(
            spacing: 15
        ) {
            
            Text("Administración del dinero")
                .font(.headline)
            
            ZStack {
                
                Circle()
                    .stroke(
                        Color.gray.opacity(0.15),
                        lineWidth: 14
                    )
                    .frame(
                        width: 150,
                        height: 150
                    )
                
                Circle()
                    .trim(
                        from: 0,
                        to: CGFloat(managementScore) / 100
                    )
                    .stroke(
                        scoreColor,
                        style: StrokeStyle(
                            lineWidth: 14,
                            lineCap: .round
                        )
                    )
                    .frame(
                        width: 150,
                        height: 150
                    )
                    .rotationEffect(
                        .degrees(-90)
                    )
                
                VStack(spacing: 2) {
                    
                    Text("\(managementScore)")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                    
                    Text("de 100")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding()
        .frame(
            maxWidth: .infinity
        )
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 24
            )
        )
    }
    
    
    private var scoreColor: Color {
        
        switch managementScore {
            
        case 90...100:
            return .green
            
        case 70..<90:
            return .blue
            
        case 50..<70:
            return .orange
            
        default:
            return .red
        }
    }
    
    
    // MARK: - Money Summary
    
    private var moneySummary: some View {
        
        VStack(
            alignment: .leading,
            spacing: 15
        ) {
            
            Text("💰 Tu dinero")
                .font(.title3)
                .fontWeight(.bold)
            
            MoneyRow(
                title: "Presupuesto",
                value: budget,
                color: .blue
            )
            
            MoneyRow(
                title: "Gastado",
                value: totalSpent,
                color: .orange
            )
            
            Divider()
            
            MoneyRow(
                title: "Dinero restante",
                value: remainingMoney,
                color: .green
            )
            
            HStack {
                
                Text("🐷 Ahorraste")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text(
                    String(
                        format: "%.0f%%",
                        savingsPercentage
                    )
                )
                .fontWeight(.bold)
                .foregroundStyle(.green)
            }
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
    }
    
    
    // MARK: - Decisions
    
    private var decisionsSummary: some View {
        
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            
            Text("🧠 Tus decisiones")
                .font(.title3)
                .fontWeight(.bold)
            
            DecisionRow(
                emoji: "🎯",
                title: "Necesidades",
                value: "\(necessaryCount) cubiertas",
                positive: necessaryCount >= 4
            )
            
            DecisionRow(
                emoji: "⭐",
                title: "Deseos",
                value: "\(optionalCount) elegidos",
                positive: optionalCount <= 2
            )
            
            DecisionRow(
                emoji: "🐷",
                title: "Ahorro",
                value: String(
                    format: "$%.0f",
                    remainingMoney
                ),
                positive: remainingMoney > 0
            )
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
    }
    
    
    // MARK: - Emergency
    
    private var emergencyCard: some View {
        
        HStack(
            alignment: .top,
            spacing: 12
        ) {
            
            Text("🚨")
                .font(.title2)
            
            VStack(
                alignment: .leading,
                spacing: 6
            ) {
                
                Text("Fondo para emergencias")
                    .font(.headline)
                
                if remainingMoney >= 100 {
                    
                    Text(
                        "Tienes suficiente dinero para afrontar "
                        + "una emergencia de $100."
                    )
                    .font(.subheadline)
                    
                } else {
                    
                    Text(
                        "Tu dinero restante es menor a $100. "
                        + "Guardar una parte puede ayudarte "
                        + "cuando ocurra algo inesperado."
                    )
                    .font(.subheadline)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(
            remainingMoney >= 100
            ? Color.green.opacity(0.12)
            : Color.orange.opacity(0.12)
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20
            )
        )
    }
    
    
    // MARK: - Learning
    
    private var learningCard: some View {
        
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            
            HStack {
                
                Text("💡")
                    .font(.title2)
                
                Text("Lo que aprendimos")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            
            LearningPoint(
                icon: "🎯",
                text: "Primero debemos cubrir nuestras necesidades."
            )
            
            LearningPoint(
                icon: "⭐",
                text: "Los deseos son cosas que queremos, pero no siempre necesitamos."
            )
            
            LearningPoint(
                icon: "🐷",
                text: "Ahorrar nos ayuda a prepararnos para el futuro."
            )
            
            LearningPoint(
                icon: "🚨",
                text: "Un fondo de emergencia puede ayudarnos cuando sucede algo inesperado."
            )
        }
        .padding()
        .background(
            Color.purple.opacity(0.10)
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
    }
    
    
    // MARK: - Reward
    
    private var rewardCard: some View {
        
        HStack(spacing: 14) {
            
            ZStack {
                
                Circle()
                    .fill(
                        Color.yellow.opacity(0.20)
                    )
                    .frame(
                        width: 60,
                        height: 60
                    )
                
                Text("⭐")
                    .font(.title)
            }
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                
                Text("Recompensa")
                    .font(.headline)
                
                Text("+\(earnedXP) XP")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.purple)
            }
            
            Spacer()
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20
            )
        )
    }
    
    
    // MARK: - Finish
    
    private var finishButton: some View {
        
        Button {
            
            dismiss()
            
        } label: {
            
            Text("Continuar")
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .frame(
                    maxWidth: .infinity
                )
                .padding()
                .background(.blue)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 18
                    )
                )
        }
    }
    
    
    // MARK: - Progress
    
    private func registerProgress() {
        
        guard !progressRegistered else {
            return
        }
        
        progressRegistered = true
        
        progressViewModel.addXP(
            earnedXP
        )
        
        progressViewModel.completeGame()
    }
}


// MARK: - Money Row

private struct MoneyRow: View {
    
    let title: String
    let value: Double
    let color: Color
    
    var body: some View {
        
        HStack {
            
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text(
                String(
                    format: "$%.0f",
                    value
                )
            )
            .fontWeight(.bold)
            .foregroundStyle(color)
        }
    }
}


// MARK: - Decision Row

private struct DecisionRow: View {
    
    let emoji: String
    let title: String
    let value: String
    let positive: Bool
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            Text(emoji)
                .font(.title3)
            
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text(value)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundStyle(
                    positive
                    ? .green
                    : .orange
                )
        }
    }
}


// MARK: - Preview

#Preview {
    
    HomeSimulationResultView(
        budget: 1000,
        totalSpent: 650,
        remainingMoney: 350,
        necessaryExpenses: [
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
            )
        ],
        optionalExpenses: []
    )
    .environment(
        ProgressViewModel()
    )
}
