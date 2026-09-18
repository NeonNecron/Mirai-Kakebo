import SwiftUI

struct GamesView: View {
    
    @Environment(ProgressViewModel.self)
    private var progressViewModel
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                
                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {
                    
                    // MARK: - Header
                    
                    VStack(
                        alignment: .leading,
                        spacing: 8
                    ) {
                        
                        Text("🎮")
                            .font(.system(size: 50))
                        
                        Text("Juegos")
                            .font(MiraiFonts.title)
                        
                        Text(
                            "Aprende sobre dinero mientras juegas."
                        )
                        .font(MiraiFonts.body)
                        .foregroundStyle(
                            MiraiColors.textSecondary
                        )
                    }
                    
                    // MARK: - Store Game
                    
                    NavigationLink {
                        StoreGameView()
                            .environment(
                                progressViewModel
                            )
                    } label: {
                        
                        GameCard(
                            emoji: "🛒",
                            title: "La Tienda de Mirai",
                            description:
                                "Aprende a diferenciar necesidades y deseos.",
                            color:
                                MiraiColors.softMatcha
                        )
                    }
                    .buttonStyle(.plain)
                    
                    // MARK: - Future Games
                    
                    GameCard(
                        emoji: "🐷",
                        title: "El reto del ahorro",
                        description:
                            "Próximamente: aprende a ahorrar para conseguir tus objetivos.",
                        color:
                            MiraiColors.softYellow
                    )
                    
                    GameCard(
                        emoji: "🧩",
                        title: "¿Necesidad o deseo?",
                        description:
                            "Próximamente: clasifica diferentes productos.",
                        color:
                            MiraiColors.softLavender
                    )
                }
                .padding()
            }
            .background(
                MiraiColors.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Juegos")
        }
    }
}

struct GameCard: View {
    
    let emoji: String
    let title: String
    let description: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            
            ZStack {
                
                RoundedRectangle(
                    cornerRadius: 18
                )
                .fill(color)
                .frame(
                    width: 70,
                    height: 70
                )
                
                Text(emoji)
                    .font(.system(size: 38))
            }
            
            VStack(
                alignment: .leading,
                spacing: 6
            ) {
                
                Text(title)
                    .font(MiraiFonts.bodyBold)
                    .foregroundStyle(
                        MiraiColors.textPrimary
                    )
                
                Text(description)
                    .font(MiraiFonts.caption)
                    .foregroundStyle(
                        MiraiColors.textSecondary
                    )
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            Image(
                systemName: "chevron.right"
            )
            .foregroundStyle(.secondary)
        }
        .padding()
        .background(
            MiraiColors.card
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 22
            )
        )
    }
}

#Preview {
    GamesView()
        .environment(
            ProgressViewModel()
        )
}
