import SwiftUI

struct SavingGameView: View {
    
    // MARK: - Environment
    
    @Environment(ProgressViewModel.self)
    private var progressViewModel
    
    // MARK: - Game State
    
    @State private var currentQuestion = 0
    @State private var selectedAnswer: Int?
    @State private var correctAnswers = 0
    @State private var showFeedback = false
    @State private var isCorrect = false
    @State private var showResult = false
    
    // MARK: - Questions
    
    private let questions: [SavingQuestion] = [
        
        SavingQuestion(
            emoji: "🐷",
            title: "La meta de Mirai",
            description: """
            Mirai tiene $340 y quiere comprar
            un juguete que cuesta $460.

            ¿Cuánto debería ahorrar para
            alcanzar su meta?
            """,
            answers: [20, 60, 120],
            correctAnswer: 120
        ),
        
        SavingQuestion(
            emoji: "🍎",
            title: "Primero las necesidades",
            description: """
            Tienes $200.

            Necesitas gastar $50 en comida.
            También quieres comprar un videojuego
            de $100.

            ¿Cuánto dinero te quedaría después
            de comprar solamente la comida?
            """,
            answers: [50, 150, 200],
            correctAnswer: 150
        ),
        
        SavingQuestion(
            emoji: "🐷",
            title: "Guardar antes de gastar",
            description: """
            Mirai recibió $300.

            Decide guardar $100 antes de comenzar
            a gastar.

            ¿Cuánto dinero puede utilizar
            para sus compras?
            """,
            answers: [100, 200, 300],
            correctAnswer: 200
        ),
        
        SavingQuestion(
            emoji: "🎮",
            title: "Una decisión difícil",
            description: """
            Tienes $250.

            Necesitas comida por $80.
            Quieres un videojuego de $120.

            ¿Cuánto dinero tendrás si compras
            ambas cosas?
            """,
            answers: [30, 50, 80],
            correctAnswer: 50
        )
    ]
    
    
    // MARK: - Current Question
    
    private var question: SavingQuestion {
        questions[currentQuestion]
    }
    
    
    // MARK: - Progress
    
    private var progress: Double {
        
        Double(currentQuestion + 1)
        / Double(questions.count)
    }
    
    
    // MARK: - Body
    
    var body: some View {
        
        ScrollView {
            
            VStack(
                alignment: .leading,
                spacing: 22
            ) {
                
                header
                
                progressBar
                
                questionCard
                
                answersSection
                
                if showFeedback {
                    feedbackCard
                }
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
        .navigationTitle("Reto del Ahorro")
        .navigationBarTitleDisplayMode(.inline)
        
        .sheet(
            isPresented: $showResult
        ) {
            
            SavingResultView(
                correctAnswers: correctAnswers,
                totalQuestions: questions.count
            )
        }
    }
    
    
    // MARK: - Header
    
    private var header: some View {
        
        HStack(
            alignment: .center,
            spacing: 14
        ) {
            
            ZStack {
                
                Circle()
                    .fill(
                        Color.orange.opacity(0.15)
                    )
                    .frame(
                        width: 65,
                        height: 65
                    )
                
                Text("🐷")
                    .font(.system(size: 36))
            }
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                
                Text("Reto del Ahorro")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text(
                    "Aprende a cuidar tu dinero."
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
    }
    
    
    // MARK: - Progress Bar
    
    private var progressBar: some View {
        
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            
            HStack {
                
                Text(
                    "Pregunta \(currentQuestion + 1)"
                )
                .font(.caption)
                .fontWeight(.semibold)
                
                Spacer()
                
                Text(
                    "\(currentQuestion + 1) de \(questions.count)"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            
            ProgressView(
                value: progress
            )
            .tint(.orange)
        }
    }
    
    
    // MARK: - Question Card
    
    private var questionCard: some View {
        
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            
            HStack {
                
                Text(question.emoji)
                    .font(.system(size: 42))
                
                Text(question.title)
                    .font(.title3)
                    .fontWeight(.bold)
            }
            
            Text(question.description)
                .font(.body)
                .lineSpacing(5)
        }
        .padding()
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
        .shadow(
            color: .black.opacity(0.04),
            radius: 6,
            y: 3
        )
    }
    
    
    // MARK: - Answers
    
    private var answersSection: some View {
        
        VStack(
            spacing: 12
        ) {
            
            ForEach(
                question.answers,
                id: \.self
            ) { answer in
                
                answerButton(
                    answer: answer
                )
            }
        }
    }
    
    
    // MARK: - Answer Button
    
    private func answerButton(
        answer: Int
    ) -> some View {
        
        Button {
            
            selectAnswer(answer)
            
        } label: {
            
            HStack {
                
                Text(
                    String(
                        format: "$%d",
                        answer
                    )
                )
                .font(.title3)
                .fontWeight(.bold)
                
                Spacer()
                
                if selectedAnswer == answer {
                    
                    Image(
                        systemName:
                            isCorrect
                            ? "checkmark.circle.fill"
                            : "xmark.circle.fill"
                    )
                    .font(.title3)
                } else {
                    
                    Image(
                        systemName: "circle"
                    )
                    .foregroundStyle(.secondary)
                }
            }
            .foregroundStyle(
                buttonTextColor(
                    answer: answer
                )
            )
            .padding()
            .frame(
                maxWidth: .infinity
            )
            .background(
                buttonBackground(
                    answer: answer
                )
            )
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
                    buttonBorderColor(
                        answer: answer
                    ),
                    lineWidth: 2
                )
            }
        }
        .buttonStyle(.plain)
        .disabled(showFeedback)
    }
    
    
    // MARK: - Answer Logic
    
    private func selectAnswer(
        _ answer: Int
    ) {
        
        selectedAnswer = answer
        
        isCorrect =
            answer == question.correctAnswer
        
        if isCorrect {
            correctAnswers += 1
        }
        
        withAnimation {
            showFeedback = true
        }
        
        // Esperamos antes de avanzar.
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1.5
        ) {
            
            nextQuestion()
        }
    }
    
    
    // MARK: - Next Question
    
    private func nextQuestion() {
        
        if currentQuestion + 1 < questions.count {
            
            withAnimation {
                
                currentQuestion += 1
                selectedAnswer = nil
                showFeedback = false
            }
            
        } else {
            
            showResult = true
        }
    }
    
    
    // MARK: - Feedback
    
    private var feedbackCard: some View {
        
        HStack(
            alignment: .top,
            spacing: 12
        ) {
            
            Text(
                isCorrect
                ? "🎉"
                : "💡"
            )
            .font(.title2)
            
            VStack(
                alignment: .leading,
                spacing: 5
            ) {
                
                Text(
                    isCorrect
                    ? "¡Muy bien!"
                    : "Vamos a aprender"
                )
                .font(.headline)
                
                Text(
                    isCorrect
                    ? "¡Elegiste una buena respuesta!"
                    : "No pasa nada. Lo importante es aprender."
                )
                .font(.subheadline)
            }
            
            Spacer()
        }
        .padding()
        .background(
            isCorrect
            ? Color.green.opacity(0.12)
            : Color.orange.opacity(0.12)
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 18
            )
        )
    }
    
    
    // MARK: - Button Styling
    
    private func buttonBackground(
        answer: Int
    ) -> Color {
        
        guard showFeedback else {
            return .white
        }
        
        if answer == question.correctAnswer {
            return Color.green.opacity(0.15)
        }
        
        if answer == selectedAnswer {
            return Color.red.opacity(0.15)
        }
        
        return .white
    }
    
    
    private func buttonBorderColor(
        answer: Int
    ) -> Color {
        
        guard showFeedback else {
            return Color.gray.opacity(0.10)
        }
        
        if answer == question.correctAnswer {
            return .green
        }
        
        if answer == selectedAnswer {
            return .red
        }
        
        return Color.gray.opacity(0.10)
    }
    
    
    private func buttonTextColor(
        answer: Int
    ) -> Color {
        
        guard showFeedback else {
            return .primary
        }
        
        if answer == question.correctAnswer {
            return .green
        }
        
        if answer == selectedAnswer {
            return .red
        }
        
        return .primary
    }
}


// MARK: - Saving Question Model

struct SavingQuestion {
    
    let emoji: String
    let title: String
    let description: String
    let answers: [Int]
    let correctAnswer: Int
}


// MARK: - Preview

#Preview {
    
    NavigationStack {
        
        SavingGameView()
            .environment(
                ProgressViewModel()
            )
    }
}
