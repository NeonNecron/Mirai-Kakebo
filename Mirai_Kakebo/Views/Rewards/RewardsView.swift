import SwiftUI

struct RewardsView: View {
    
    @Environment(ProgressViewModel.self)
    private var progressViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    header
                    
                    levelCard
                    
                    statistics
                    
                    achievements
                }
                .padding()
            }
            .background(
                LinearGradient(
                    colors: [
                        Color.yellow.opacity(0.08),
                        Color.purple.opacity(0.06),
                        Color.white
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
            )
            .navigationTitle("Mis recompensas")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    // MARK: - Header
    
    private var header: some View {
        VStack(spacing: 10) {
            
            Text("🏆")
                .font(.system(size: 60))
            
            Text("¡Sigue aprendiendo!")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(
                "Cada actividad que completas te ayuda a aprender y ganar recompensas."
            )
            .font(.subheadline)
            .foregroundStyle(.secondary)
            .multilineTextAlignment(.center)
        }
        .padding(.vertical, 10)
    }
    
    // MARK: - Level
    
    private var levelCard: some View {
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            
            HStack {
                
                VStack(
                    alignment: .leading,
                    spacing: 5
                ) {
                    
                    Text("NIVEL ACTUAL")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundStyle(.secondary)
                    
                    Text(
                        "Nivel \(progressViewModel.level)"
                    )
                    .font(.largeTitle)
                    .fontWeight(.bold)
                }
                
                Spacer()
                
                Text("⭐")
                    .font(.system(size: 45))
            }
            
            ProgressView(
                value: progressViewModel.levelProgress
            )
            .tint(.purple)
            
            HStack {
                
                Text(
                    "\(progressViewModel.currentLevelExperience) XP"
                )
                .font(.caption)
                .fontWeight(.bold)
                
                Spacer()
                
                Text("1000 XP")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(
            LinearGradient(
                colors: [
                    Color.purple.opacity(0.15),
                    Color.blue.opacity(0.10)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 24
            )
        )
    }
    
    // MARK: - Statistics
    
    private var statistics: some View {
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            
            Text("📊 Mis estadísticas")
                .font(.title3)
                .fontWeight(.bold)
            
            HStack(spacing: 12) {
                
                RewardStatistic(
                    emoji: "⭐",
                    value: "\(progressViewModel.experience)",
                    title: "XP"
                )
                
                RewardStatistic(
                    emoji: "🎮",
                    value: "\(progressViewModel.completedGames)",
                    title: "Juegos"
                )
                
                RewardStatistic(
                    emoji: "📚",
                    value: "\(progressViewModel.completedLessons)",
                    title: "Lecciones"
                )
            }
        }
    }
    
    // MARK: - Achievements
    
    private var achievements: some View {
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            
            Text("🏅 Mis logros")
                .font(.title3)
                .fontWeight(.bold)
            
            AchievementCard(
                emoji: "⭐",
                title: "Primer paso",
                description: "Completa tu primera actividad.",
                requiredXP: 100,
                currentXP: progressViewModel.experience
            )
            
            AchievementCard(
                emoji: "🐷",
                title: "Pequeño ahorrador",
                description: "Consigue 500 XP.",
                requiredXP: 500,
                currentXP: progressViewModel.experience
            )
            
            AchievementCard(
                emoji: "🛒",
                title: "Comprador inteligente",
                description: "Consigue 750 XP.",
                requiredXP: 750,
                currentXP: progressViewModel.experience
            )
            
            AchievementCard(
                emoji: "📚",
                title: "Aprendiz de economía",
                description: "Consigue 1,000 XP.",
                requiredXP: 1000,
                currentXP: progressViewModel.experience
            )
            
            AchievementCard(
                emoji: "🏆",
                title: "Maestro Kakebo",
                description: "Consigue 5,000 XP.",
                requiredXP: 5000,
                currentXP: progressViewModel.experience
            )
        }
    }
}

struct RewardStatistic: View {
    
    let emoji: String
    let value: String
    let title: String
    
    var body: some View {
        VStack(spacing: 8) {
            
            Text(emoji)
                .font(.title2)
            
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(.white)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 18
            )
        )
        .shadow(
            color: .black.opacity(0.05),
            radius: 5,
            y: 3
        )
    }
}

struct AchievementCard: View {
    
    let emoji: String
    let title: String
    let description: String
    let requiredXP: Int
    let currentXP: Int
    
    private var unlocked: Bool {
        currentXP >= requiredXP
    }
    
    var body: some View {
        HStack(spacing: 15) {
            
            ZStack {
                
                Circle()
                    .fill(
                        unlocked
                        ? Color.yellow.opacity(0.20)
                        : Color.gray.opacity(0.12)
                    )
                    .frame(
                        width: 60,
                        height: 60
                    )
                
                Text(
                    unlocked ? emoji : "🔒"
                )
                .font(.title)
            }
            
            VStack(
                alignment: .leading,
                spacing: 5
            ) {
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                if unlocked {
                    Text("✓ DESBLOQUEADO")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                } else {
                    Text(
                        "\(requiredXP) XP necesarios"
                    )
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(.white)
        .opacity(unlocked ? 1 : 0.75)
        .clipShape(
            RoundedRectangle(
                cornerRadius: 20
            )
        )
        .shadow(
            color: .black.opacity(0.05),
            radius: 5,
            y: 3
        )
    }
}

#Preview {
    RewardsView()
        .environment(ProgressViewModel())
}
