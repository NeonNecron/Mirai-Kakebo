import SwiftUI

struct LessonCardView: View {
    
    let lesson: Lesson
    let isCompleted: Bool
    
    var body: some View {
        HStack(spacing: 15) {
            
            ZStack {
                RoundedRectangle(
                    cornerRadius: MiraiTheme.mediumRadius
                )
                .fill(
                    MiraiColors.education.opacity(0.15)
                )
                
                Text(lesson.emoji)
                    .font(.system(size: 32))
            }
            .frame(
                width: 64,
                height: 64
            )
            
            VStack(
                alignment: .leading,
                spacing: 6
            ) {
                
                Text(lesson.title)
                    .font(MiraiFonts.headline)
                
                Text(lesson.description)
                    .font(MiraiFonts.caption)
                    .foregroundStyle(
                        MiraiColors.textSecondary
                    )
                
                HStack(spacing: 10) {
                    
                    Label(
                        "\(lesson.duration) min",
                        systemImage: "clock"
                    )
                    
                    Label(
                        "+\(lesson.xpReward) XP",
                        systemImage: "star.fill"
                    )
                }
                .font(.caption2)
                .foregroundStyle(
                    MiraiColors.textSecondary
                )
            }
            
            Spacer()
            
            if isCompleted {
                Image(
                    systemName: "checkmark.circle.fill"
                )
                .foregroundStyle(
                    MiraiColors.success
                )
            } else {
                Image(
                    systemName: "chevron.right"
                )
                .foregroundStyle(
                    MiraiColors.textTertiary
                )
            }
        }
        .padding(MiraiTheme.cardPadding)
        .miraiCard()
    }
}
