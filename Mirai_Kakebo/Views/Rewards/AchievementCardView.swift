import SwiftUI

struct AchievementCardView: View {
    
    let achievement: Achievement
    let currentXP: Int
    
    private var isUnlocked: Bool {
        currentXP >= achievement.requiredXP
    }
    
    private var progress: Double {
        min(
            Double(currentXP)
            / Double(achievement.requiredXP),
            1
        )
    }
    
    var body: some View {
        HStack(spacing: 15) {
            
            ZStack {
                Circle()
                    .fill(
                        isUnlocked
                        ? MiraiColors.gold.opacity(0.18)
                        : MiraiColors.primary.opacity(0.07)
                    )
                
                Text(achievement.emoji)
                    .font(.system(size: 32))
                    .opacity(
                        isUnlocked ? 1 : 0.45
                    )
            }
            .frame(
                width: 65,
                height: 65
            )
            
            VStack(
                alignment: .leading,
                spacing: 6
            ) {
                
                HStack {
                    
                    Text(achievement.title)
                        .font(MiraiFonts.headline)
                    
                    Spacer()
                    
                    if isUnlocked {
                        Image(
                            systemName:
                                "checkmark.seal.fill"
                        )
                        .foregroundStyle(
                            MiraiColors.gold
                        )
                    }
                }
                
                Text(achievement.description)
                    .font(MiraiFonts.caption)
                    .foregroundStyle(
                        MiraiColors.textSecondary
                    )
                
                if !isUnlocked {
                    ProgressBar(
                        progress: progress,
                        color: MiraiColors.yellow
                    )
                    .frame(height: 8)
                    
                    Text(
                        "\(currentXP) / \(achievement.requiredXP) XP"
                    )
                    .font(.caption2)
                    .foregroundStyle(
                        MiraiColors.textTertiary
                    )
                } else {
                    Text("¡Logro desbloqueado!")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundStyle(
                            MiraiColors.success
                        )
                }
            }
        }
        .padding(MiraiTheme.cardPadding)
        .opacity(
            isUnlocked ? 1 : 0.85
        )
        .miraiCard()
    }
}
