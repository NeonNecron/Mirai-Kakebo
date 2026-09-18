import SwiftUI

struct GoalsView: View {
    
    private let goals = [
        GoalItem(
            title: "Videojuego",
            icon: "gamecontroller.fill",
            saved: 300,
            target: 500,
            color: MiraiTheme.green
        ),
        GoalItem(
            title: "Bicicleta",
            icon: "bicycle",
            saved: 250,
            target: 1000,
            color: MiraiTheme.lavender
        ),
        GoalItem(
            title: "Regalo",
            icon: "gift.fill",
            saved: 150,
            target: 300,
            color: MiraiTheme.yellow
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                Text("Mis metas 🎯")
                    .font(MiraiFonts.display)
                    .foregroundStyle(MiraiTheme.navy)
                
                Text("Ahorra poco a poco para conseguir lo que quieres.")
                    .font(MiraiFonts.body)
                    .foregroundStyle(
                        MiraiTheme.navy.opacity(0.7)
                    )
                
                ForEach(goals) { goal in
                    GoalCard(goal: goal)
                }
                
                MiraiButton(
                    title: "Crear una meta",
                    systemImage: "plus.circle.fill",
                    color: MiraiTheme.coral
                ) {
                    print("Crear nueva meta")
                }
            }
            .padding(MiraiTheme.screenPadding)
        }
        .background(MiraiTheme.background)
        .navigationTitle("Mis metas")
        .navigationBarTitleDisplayMode(.inline)
    }
}


// MARK: - Modelo

private struct GoalItem: Identifiable {
    
    let id = UUID()
    let title: String
    let icon: String
    let saved: Double
    let target: Double
    let color: Color
    
    var progress: Double {
        min(saved / target, 1)
    }
}


// MARK: - Tarjeta

private struct GoalCard: View {
    
    let goal: GoalItem
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            HStack(spacing: 14) {
                
                ZStack {
                    Circle()
                        .fill(goal.color.opacity(0.2))
                        .frame(width: 58, height: 58)
                    
                    Image(systemName: goal.icon)
                        .font(.system(size: 25, weight: .bold))
                        .foregroundStyle(goal.color)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    
                    Text(goal.title)
                        .font(MiraiFonts.headline)
                        .foregroundStyle(MiraiTheme.navy)
                    
                    Text(
                        "\(goal.saved.formatted(.number.precision(.fractionLength(0)))) / \(goal.target.formatted(.number.precision(.fractionLength(0)))) MXN"
                    )
                    .font(MiraiFonts.caption)
                    .foregroundStyle(
                        MiraiTheme.navy.opacity(0.65)
                    )
                }
                
                Spacer()
                
                Text("\(Int(goal.progress * 100))%")
                    .font(MiraiFonts.xp)
                    .foregroundStyle(MiraiTheme.green)
            }
            
            ProgressBar(
                progress: goal.progress,
                color: MiraiTheme.green
            )
        }
        .padding(MiraiTheme.cardPadding)
        .background(Color.white.opacity(0.8))
        .clipShape(
            RoundedRectangle(
                cornerRadius: MiraiTheme.largeRadius
            )
        )
        .shadow(
            color: MiraiTheme.navy.opacity(0.08),
            radius: 8,
            y: 4
        )
    }
}


#Preview {
    NavigationStack {
        GoalsView()
    }
}
