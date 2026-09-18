import SwiftUI

struct ThemePreviewView: View {
    
    var body: some View {
        
        MiraiBackground {
            
            ScrollView {
                
                VStack(
                    alignment: .leading,
                    spacing: MiraiTheme.largeSpacing
                ) {
                    
                    // MARK: Header
                    
                    VStack(
                        alignment: .leading,
                        spacing: 6
                    ) {
                        
                        Text("Mirai Kakebo")
                            .font(MiraiFonts.display)
                            .foregroundStyle(
                                MiraiColors.primary
                            )
                        
                        Text("みらい かけぼ")
                            .font(MiraiFonts.japaneseAccent)
                            .foregroundStyle(
                                MiraiColors.sakura
                            )
                        
                        Text(
                            "Aprende • Ahorra • Cumple tus metas"
                        )
                        .font(MiraiFonts.body)
                        .foregroundStyle(
                            MiraiColors.textSecondary
                        )
                    }
                    
                    
                    // MARK: Money
                    
                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {
                        
                        Text("💰 Dinero disponible")
                            .font(MiraiFonts.headline)
                            .foregroundStyle(
                                MiraiColors.primary
                            )
                        
                        Text("$1,000")
                            .font(MiraiFonts.money)
                            .foregroundStyle(
                                MiraiColors.money
                            )
                        
                        Text("Puedes administrar tu dinero")
                            .font(MiraiFonts.caption)
                            .foregroundStyle(
                                MiraiColors.textSecondary
                            )
                    }
                    .padding(
                        MiraiTheme.cardPadding
                    )
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )
                    .miraiCard(
                        background: MiraiColors.softYellow
                    )
                    
                    
                    // MARK: Categories
                    
                    Text("Categorías")
                        .font(MiraiFonts.title)
                        .foregroundStyle(
                            MiraiColors.primary
                        )
                    
                    HStack(spacing: 12) {
                        
                        category(
                            emoji: "🍚",
                            title: "Necesidades",
                            color: MiraiColors.needs
                        )
                        
                        category(
                            emoji: "🎮",
                            title: "Diversión",
                            color: MiraiColors.fun
                        )
                    }
                    
                    HStack(spacing: 12) {
                        
                        category(
                            emoji: "📚",
                            title: "Educación",
                            color: MiraiColors.education
                        )
                        
                        category(
                            emoji: "🎁",
                            title: "Otros",
                            color: MiraiColors.other
                        )
                    }
                    
                    
                    // MARK: XP
                    
                    HStack {
                        
                        Text("⭐")
                            .font(.system(size: 30))
                        
                        VStack(
                            alignment: .leading
                        ) {
                            
                            Text("Experiencia")
                                .font(MiraiFonts.caption)
                            
                            Text("+150 XP")
                                .font(MiraiFonts.xp)
                        }
                        
                        Spacer()
                    }
                    .padding(
                        MiraiTheme.cardPadding
                    )
                    .miraiCard(
                        background: MiraiColors.softLavender
                    )
                }
                .padding(
                    MiraiTheme.screenPadding
                )
            }
        }
    }
    
    
    // MARK: - Category
    
    private func category(
        emoji: String,
        title: String,
        color: Color
    ) -> some View {
        
        VStack(spacing: 10) {
            
            Text(emoji)
                .font(.system(size: 34))
            
            Text(title)
                .font(MiraiFonts.captionBold)
                .multilineTextAlignment(.center)
                .foregroundStyle(
                    MiraiColors.primary
                )
        }
        .frame(
            maxWidth: .infinity
        )
        .padding(
            MiraiTheme.cardPadding
        )
        .miraiCard(
            background: color.opacity(0.25),
            radius: MiraiTheme.mediumRadius
        )
    }
}


#Preview {
    ThemePreviewView()
}
