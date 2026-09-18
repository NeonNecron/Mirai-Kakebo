import SwiftUI

struct ProgressCardView: View {
    
    let progress: UserProgress
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 14
        ) {
            
            HStack {
                
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    Text("Tu progreso")
                        .font(MiraiFonts.headline)
                    
                    Text("Nivel \(progress.level)")
                        .font(MiraiFonts.caption)
                        .foregroundStyle(
                            MiraiColors.textSecondary
                        )
                }
                
                Spacer()
                
                Text("⭐ \(progress.experience) XP")
                    .font(MiraiFonts.xp)
                    .foregroundStyle(
                        MiraiColors.gold
                    )
            }
            
            ProgressBar(
                progress: progress.levelProgress,
                color: MiraiColors.yellow
            )
            
            HStack {
                
                Text(
                    "\(progress.experience) XP"
                )
                
                Spacer()
                
                Text(
                    "\(progress.experienceForNextLevel) XP"
                )
            }
            .font(MiraiFonts.caption)
            .foregroundStyle(
                MiraiColors.textSecondary
            )
        }
        .padding(MiraiTheme.cardPadding)
        .miraiCard()
    }
}
