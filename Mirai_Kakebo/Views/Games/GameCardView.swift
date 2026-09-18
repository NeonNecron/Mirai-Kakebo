import SwiftUI

struct GameCardView: View {
    
    let game: Game
    
    var body: some View {
        HStack(
            alignment: .top,
            spacing: 15
        ) {
            
            CategoryIcon(
                category: categoryForGame,
                size: 68
            )
            
            VStack(
                alignment: .leading,
                spacing: 7
            ) {
                
                Text(game.title)
                    .font(MiraiFonts.headline)
                    .foregroundStyle(MiraiColors.textPrimary)
                
                Text(game.description)
                    .font(MiraiFonts.caption)
                    .foregroundStyle(MiraiColors.textSecondary)
                    .multilineTextAlignment(.leading)
                
                HStack(spacing: 10) {
                    
                    Label(
                        "+\(game.xpReward) XP",
                        systemImage: "star.fill"
                    )
                    .font(MiraiFonts.captionBold)
                    .foregroundStyle(MiraiColors.gold)
                    
                    Text("•")
                        .foregroundStyle(MiraiColors.textTertiary)
                    
                    Text(game.difficulty)
                        .font(MiraiFonts.captionBold)
                        .foregroundStyle(MiraiColors.matcha)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(MiraiColors.textTertiary)
        }
        .padding(MiraiTheme.cardPadding)
        .miraiCard()
    }
    
    private var categoryForGame: Category {
        switch game.category {
        case "Ahorro":
            return .savings
        case "Compras":
            return .food
        case "Hogar":
            return .home
        default:
            return .other
        }
    }
}
