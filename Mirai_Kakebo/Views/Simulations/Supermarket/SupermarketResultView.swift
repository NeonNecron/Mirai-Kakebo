import SwiftUI

struct SupermarketResultView: View {
    
    // MARK: - Environment
    
    @Environment(ProgressViewModel.self)
    private var progressViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    // MARK: - Input
    
    let budget: Double
    let total: Double
    let remaining: Double
    let selectedProducts: [Product]
    let allNeedsSelected: Bool
    
    // MARK: - State
    
    @State private var xpAdded = false
    
    // MARK: - Calculations
    
    private var needsPurchased: [Product] {
        selectedProducts.filter {
            $0.isNeed
        }
    }
    
    private var wantsPurchased: [Product] {
        selectedProducts.filter {
            !$0.isNeed
        }
    }
    
    private var needsCount: Int {
        needsPurchased.count
    }
    
    private var wantsCount: Int {
        wantsPurchased.count
    }
    
    private var percentageSpent: Double {
        
        guard budget > 0 else {
            return 0
        }
        
        return total / budget
    }
    
    private var savingsPercentage: Double {
        
        guard budget > 0 else {
            return 0
        }
        
        return remaining / budget
    }
    
    // MARK: - Score
    
    private var score: Int {
        
        var result = 0
        
        // Cubrió todas las necesidades
        if allNeedsSelected {
            result += 50
        }
        
        // Conservó dinero
        if remaining >= 100 {
            result += 30
        } else if remaining >= 50 {
            result += 20
        } else if remaining > 0 {
            result += 10
        }
        
        // Eligió pocos deseos
        if wantsCount == 0 {
            result += 20
        } else if wantsCount <= 2 {
            result += 15
        } else if wantsCount <= 3 {
            result += 10
        }
        
        return min(result, 100)
    }
    
    // MARK: - XP
    
    private var earnedXP: Int {
        
        switch score {
            
        case 90...100:
            return 100
            
        case 70..<90:
            return 75
            
        default:
            return 50
        }
    }
    
    // MARK: - Feedback
    
    private var resultTitle: String {
        
        switch score {
            
        case 90...100:
            return "¡Excelente administración!"
            
        case 70..<90:
            return "¡Muy buena decisión!"
            
        default:
            return "¡Buen trabajo!"
        }
    }
    
    private var resultEmoji: String {
        
        switch score {
            
        case 90...100:
            return "🌟"
            
        case 70..<90:
            return "😊"
            
        default:
            return "🦊"
        }
    }
    
    private var feedbackMessage: String {
        
        if remaining >= 100 {
            
            return """
            ¡Excelente! Cubriste las cosas importantes \
            y todavía conservaste bastante dinero. \
            Ahorrar una parte de tu dinero puede ayudarte \
            cuando aparezca algo inesperado.
            """
            
        } else if remaining >= 50 {
            
            return """
            ¡Muy bien! Compraste lo necesario y todavía \
            tienes dinero disponible. Recuerda que no \
            tienes que gastar todo tu presupuesto.
            """
            
        } else {
            
            return """
            Cubriste tus necesidades, pero gastaste casi \
            todo tu presupuesto. La próxima vez puedes \
            pensar si realmente necesitas todos los \
            productos que elegiste.
            """
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        
        NavigationStack {
            
            ScrollView {
                
                VStack(spacing: 22) {
                    
                    resultHeader
                    
                    scoreCard
                    
                    purchaseSummary
                    
                    learningCard
                    
                    rewardCard
                    
                    finishButton
                }
                .padding()
            }
            .background(
                LinearGradient(
                    colors: [
                        Color.green.opacity(0.08),
                        Color.yellow.opacity(0.06),
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
        
        VStack(spacing: 10) {
            
            Text(resultEmoji)
                .font(.system(size: 70))
            
            Text(resultTitle)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Text(feedbackMessage)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.top, 10)
    }
    
    // MARK: - Score Card
    
    private var scoreCard: some View {
        
        VStack(spacing: 12) {
            
            Text("Tu administración")
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
                        to: CGFloat(score) / 100
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
                    
                    Text("\(score)")
                        .font(.system(size: 38))
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
        .shadow(
            color: .black.opacity(0.05),
            radius: 8,
            y: 4
        )
    }
    
    private var scoreColor: Color {
        
        switch score {
            
        case 90...100:
            return .green
            
        case 70..<90:
            return .blue
            
        default:
            return .orange
        }
    }
    
    // MARK: - Purchase Summary
    
    private var purchaseSummary: some View {
        
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            
            Text("🛒 Tu compra")
                .font(.title3)
                .fontWeight(.bold)
            
            HStack {
                
                SummaryItem(
                    emoji: "🎯",
                    title: "Necesidades",
                    value: "\(needsCount)"
                )
                
                SummaryItem(
                    emoji: "⭐",
                    title: "Deseos",
                    value: "\(wantsCount)"
                )
            }
            
            Divider()
            
            HStack {
                
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    
                    Text("Gastaste")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(
                        String(
                            format: "$%.2f",
                            total
                        )
                    )
                    .font(.headline)
                }
                
                Spacer()
                
                VStack(
                    alignment: .trailing,
                    spacing: 4
                ) {
                    
                    Text("Conservaste")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Text(
                        String(
                            format: "$%.2f",
                            remaining
                        )
                    )
                    .font(.headline)
                    .foregroundStyle(.green)
                }
            }
            
            ProgressView(
                value: percentageSpent
            )
            .tint(.orange)
            
            Text(
                String(
                    format: "%.0f%% de tu presupuesto utilizado",
                    percentageSpent * 100
                )
            )
            .font(.caption)
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
    
    // MARK: - Learning Card
    
    private var learningCard: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            HStack {
                
                Text("💡")
                    .font(.title2)
                
                Text("Lo que aprendiste")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            
            Text(
                "En Kakebo aprendemos a pensar antes "
                + "de gastar nuestro dinero."
            )
            .font(.subheadline)
            
            VStack(
                alignment: .leading,
                spacing: 10
            ) {
                
                LearningPoint(
                    icon: "🎯",
                    text: "Primero cubre tus necesidades."
                )
                
                LearningPoint(
                    icon: "⭐",
                    text: "Después puedes elegir algunos deseos."
                )
                
                LearningPoint(
                    icon: "🐷",
                    text: "Intenta conservar una parte de tu dinero."
                )
            }
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
        
        HStack {
            
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
                .background(
                    Color.green
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 18
                    )
                )
        }
    }
    
    // MARK: - Progress
    
    private func registerProgress() {
        
        guard !xpAdded else {
            return
        }
        
        xpAdded = true
        
        progressViewModel.addXP(
            earnedXP
        )
        
        progressViewModel.completeGame()
    }
}


// MARK: - Summary Item

struct SummaryItem: View {
    
    let emoji: String
    let title: String
    let value: String
    
    var body: some View {
        
        HStack(spacing: 8) {
            
            Text(emoji)
                .font(.title3)
            
            VStack(
                alignment: .leading,
                spacing: 2
            ) {
                
                Text(value)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding()
        .background(
            Color.gray.opacity(0.07)
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 14
            )
        )
    }
}


// MARK: - Learning Point

struct LearningPoint: View {
    
    let icon: String
    let text: String
    
    var body: some View {
        
        HStack(
            alignment: .top,
            spacing: 10
        ) {
            
            Text(icon)
            
            Text(text)
                .font(.subheadline)
        }
    }
}


// MARK: - Preview

#Preview {
    
    SupermarketResultView(
        budget: 300,
        total: 185,
        remaining: 115,
        selectedProducts: [
            Product(
                name: "Pan",
                emoji: "🍞",
                price: 40,
                category: .food,
                isNeed: true
            ),
            Product(
                name: "Leche",
                emoji: "🥛",
                price: 35,
                category: .drink,
                isNeed: true
            ),
            Product(
                name: "Fruta",
                emoji: "🍎",
                price: 60,
                category: .food,
                isNeed: true
            ),
            Product(
                name: "Chocolate",
                emoji: "🍫",
                price: 30,
                category: .food,
                isNeed: false
            ),
            Product(
                name: "Galletas",
                emoji: "🍪",
                price: 20,
                category: .food,
                isNeed: false
            )
        ],
        allNeedsSelected: true
    )
    .environment(
        ProgressViewModel()
    )
}
