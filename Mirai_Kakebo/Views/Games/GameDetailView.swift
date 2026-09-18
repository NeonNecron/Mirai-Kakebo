import SwiftUI

struct GameDetailView: View {

    @Environment(ProgressViewModel.self)
    private var progressViewModel

    let game: Game

    @State private var completed = false

    var body: some View {
        ScrollView {
            VStack(
                alignment: .leading,
                spacing: MiraiTheme.largeSpacing
            ) {

                // MARK: - Header

                VStack(
                    alignment: .leading,
                    spacing: MiraiTheme.mediumSpacing
                ) {

                    HStack {
                        Text(game.emoji)
                            .font(.system(size: 48))

                        Spacer()

                        VStack(
                            alignment: .trailing,
                            spacing: 4
                        ) {
                            Text("+\(game.xpReward) XP")
                                .font(MiraiFonts.xp)
                                .foregroundStyle(
                                    MiraiColors.gold
                                )

                            Text(game.difficulty)
                                .font(MiraiFonts.captionBold)
                                .foregroundStyle(
                                    MiraiColors.textSecondary
                                )
                        }
                    }

                    Text(game.title)
                        .font(MiraiFonts.display)
                        .foregroundStyle(
                            MiraiColors.textPrimary
                        )

                    Text(game.description)
                        .font(MiraiFonts.body)
                        .foregroundStyle(
                            MiraiColors.textSecondary
                        )
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )
                }
                .padding(MiraiTheme.cardPadding)
                .miraiCard()

                // MARK: - Game Information

                HStack(spacing: 12) {

                    GameInfoCard(
                        icon: "tag.fill",
                        title: "Categoría",
                        value: game.category,
                        color: MiraiColors.lavender
                    )

                    GameInfoCard(
                        icon: "clock.fill",
                        title: "Duración",
                        value: "\(game.duration) min",
                        color: MiraiColors.orange
                    )
                }

                // MARK: - Instructions

                VStack(
                    alignment: .leading,
                    spacing: MiraiTheme.mediumSpacing
                ) {

                    HStack(spacing: 10) {

                        Image(systemName: "gamecontroller.fill")
                            .foregroundStyle(
                                MiraiColors.yellow
                            )

                        Text("¿Cómo jugar?")
                            .font(MiraiFonts.headline)
                            .foregroundStyle(
                                MiraiColors.textPrimary
                            )
                    }

                    Text(game.instructions)
                        .font(MiraiFonts.body)
                        .foregroundStyle(
                            MiraiColors.textSecondary
                        )
                        .fixedSize(
                            horizontal: false,
                            vertical: true
                        )
                }
                .padding(MiraiTheme.cardPadding)
                .miraiCard(
                    background: MiraiColors.softLavender
                )

                // MARK: - Reward

                VStack(
                    alignment: .leading,
                    spacing: 12
                ) {

                    HStack(spacing: 10) {

                        Image(systemName: "star.fill")
                            .foregroundStyle(
                                MiraiColors.yellow
                            )

                        Text("Recompensa")
                            .font(MiraiFonts.headline)
                            .foregroundStyle(
                                MiraiColors.textPrimary
                            )
                    }

                    HStack {

                        Image(systemName: "bolt.fill")
                            .foregroundStyle(
                                MiraiColors.gold
                            )

                        Text("+\(game.xpReward) XP")
                            .font(MiraiFonts.moneySmall)
                            .foregroundStyle(
                                MiraiColors.gold
                            )

                        Spacer()
                    }
                }
                .padding(MiraiTheme.cardPadding)
                .miraiCard(
                    background: MiraiColors.softYellow
                )

                // MARK: - Completion

                if completed {

                    VStack(
                        alignment: .center,
                        spacing: 12
                    ) {

                        Image(
                            systemName:
                                "checkmark.circle.fill"
                        )
                        .font(
                            .system(
                                size: 52,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(
                            MiraiColors.matcha
                        )

                        Text("¡Juego completado!")
                            .font(MiraiFonts.headline)
                            .foregroundStyle(
                                MiraiColors.textPrimary
                            )

                        Text(
                            "Has ganado \(game.xpReward) XP"
                        )
                        .font(MiraiFonts.body)
                        .foregroundStyle(
                            MiraiColors.textSecondary
                        )
                        .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(MiraiTheme.cardPadding)
                    .miraiCard(
                        background: MiraiColors.softMatcha
                    )

                } else {

                    MiraiButton(
                        title: "Completar juego",
                        systemImage: "checkmark.circle.fill",
                        color: MiraiColors.matcha
                    ) {

                        withAnimation {

                            progressViewModel.addXP(
                                game.xpReward
                            )

                            progressViewModel.completeGame()

                            completed = true
                        }
                    }
                }
            }
            .padding(
                .horizontal,
                MiraiTheme.screenPadding
            )
            .padding(
                .vertical,
                MiraiTheme.largeSpacing
            )
        }
        .background(
            MiraiColors.background
                .ignoresSafeArea()
        )
        .navigationTitle("Juego")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        GameDetailView(
            game: Game(
                title: "Reto del Ahorro",
                description: "Aprende a ahorrar tomando buenas decisiones.",
                emoji: "💰",
                xpReward: 100,
                difficulty: "Fácil",
                category: "Ahorro",
                instructions: "Selecciona las opciones que te permitan ahorrar más dinero.",
                duration: 5
            )
        )
        .environment(
            ProgressViewModel()
        )
    }
}
