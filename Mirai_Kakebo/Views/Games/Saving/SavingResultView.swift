import SwiftUI

struct SavingResultView: View {
    
    // MARK: - Environment
    
    @Environment(ProgressViewModel.self)
    private var progressViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    // MARK: - Data
    
    let correctAnswers: Int
    let totalQuestions: Int
    
    // MARK: - State
    
    @State private var xpAdded = false
    
    
    // MARK: - Score
    
    private var score: Int {
        
        guard totalQuestions > 0 else {
            return 0
        }
        
        return Int(
            Double(correctAnswers)
            / Double(totalQuestions)
            * 100
        )
    }
    
    
    // MARK: - XP
    
    private var earnedXP: Int {
        
        switch score {
            
        case 90...100:
            return 100
            
        case 70..<90:
            return 75
            
        case 50..<70:
            return 60
            
        default:
            return 50
        }
    }
    
    
    // MARK: - Result Text
    
    private var resultEmoji: String {
        
        switch score {
            
        case 90...100:
            return "🌟"
            
        case 70..<90:
            return "😊"
            
        case 50..<70:
            return "🐷"
            
        default:
            return "🦊"
        }
    }
    
    
    private var resultTitle: String {
        
        switch score {
            
        case 90...100:
            return "¡Excelente ahorrador!"
            
        case 70..<90:
            return "¡Muy buen trabajo!"
            
        case 50..<70:
            return "¡Vas aprendiendo!"
            
        default:
            return "¡Buen intento!"
        }
    }
    
    
    private var resultMessage: String {
        
        switch score {
            
        case 90...100:
            return """
            Comprendes muy bien la importancia \
            de ahorrar y pensar antes de gastar.
            """
            
        case 70..<90:
            return """
            Tienes buenas ideas sobre el ahorro. \
            Sigue practicando para tomar decisiones \
            cada vez mejores.
            """
            
        case 50..<70:
            return """
            Ya estás comenzando a entender cómo \
            funciona el ahorro. ¡Practiquemos un poco más!
            """
            
        default:
            return """
            No te preocupes. Equivocarse es parte \
            de aprender. Puedes intentarlo nuevamente.
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
                    
                    answerSummary
                    
                    learningCard
                    
                    rewardCard
                    
                    finishButton
                }
                .padding()
            }
            .background(
                LinearGradient(
                    colors: [
                        Color.orange.opacity(0.08),
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
            spacing: 14
        ) {
            
            Text("Tu resultado")
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
                
                VStack(
                    spacing: 2
                ) {
                    
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
    }
    
    
    private var scoreColor: Color {
        
        switch score {
            
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
    
    
    // MARK: - Answer Summary
    
    private var answerSummary: some View {
        
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            
            Text("📊 Tus respuestas")
                .font(.title3)
                .fontWeight(.bold)
            
            HStack {
                
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    
                    Text("\(correctAnswers)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                    
                    Text("Correctas")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                
                Spacer()
                
                VStack(
                    alignment: .trailing,
                    spacing: 4
                ) {
                    
                    Text(
                        "\(totalQuestions - correctAnswers)"
                    )
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.orange)
                    
                    Text("Para practicar")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            
            ProgressView(
                value: Double(correctAnswers),
                total: Double(totalQuestions)
            )
            .tint(.green)
        }
        .padding()
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
    }
    
    
    // MARK: - Learning
    
    private var learningCard: some View {
        
        VStack(
            alignment: .leading,
            spacing: 12
        ) {
            
            HStack {
                
                Text("💡")
                    .font(.title2)
                
                Text("Recuerda")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            
            LearningPoint(
                icon: "🐷",
                text: "Ahorrar significa guardar dinero para el futuro."
            )
            
            LearningPoint(
                icon: "🎯",
                text: "Una meta puede ayudarte a saber cuánto necesitas ahorrar."
            )
            
            LearningPoint(
                icon: "🧠",
                text: "Pensar antes de gastar te ayuda a tomar mejores decisiones."
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
        
        HStack(
            spacing: 14
        ) {
            
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


// MARK: - Preview

#Preview {
    
    SavingResultView(
        correctAnswers: 4,
        totalQuestions: 4
    )
    .environment(
        ProgressViewModel()
    )
}
