import SwiftUI

struct HomeView: View {

    @Environment(ProgressViewModel.self)
    private var progressViewModel

    @State private var kiri = KiriManager()

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(
                    spacing: MiraiTheme.largeSpacing
                ) {

                    // MARK: - Welcome

                    VStack(
                        alignment: .leading,
                        spacing: 6
                    ) {

                        Text("Mirai Kakebo")
                            .font(MiraiFonts.display)
                            .foregroundStyle(
                                MiraiTheme.navy
                            )

                        Text(
                            "Tu dinero, tus decisiones, tu futuro."
                        )
                        .font(MiraiFonts.body)
                        .foregroundStyle(
                            MiraiColors.textSecondary
                        )
                    }
                    .frame(
                        maxWidth: .infinity,
                        alignment: .leading
                    )

                    // MARK: - Kiri

                    VStack(
                        spacing: MiraiTheme.mediumSpacing
                    ) {

                        KiriView(
                            expression: kiri.expression,
                            size: 150
                        )

                        KiriDialogueView(
                            message: kiri.message
                        )
                    }

                    // MARK: - Progress

                    progressCard

                    // MARK: - Actions

                    VStack(
                        alignment: .leading,
                        spacing: MiraiTheme.mediumSpacing
                    ) {

                        Text("¿Qué quieres hacer?")
                            .font(MiraiFonts.headline)
                            .foregroundStyle(
                                MiraiTheme.navy
                            )

                        actionGrid
                    }

                    // MARK: - Weekly Summary

                    weeklySummary
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
            .background(MiraiTheme.background)
            .navigationBarHidden(true)
        }
    }

    // MARK: - Progress Card

    private var progressCard: some View {

        VStack(
            alignment: .leading,
            spacing: 16
        ) {

            HStack {

                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {

                    Text(
                        "Nivel \(progressViewModel.level)"
                    )
                    .font(MiraiFonts.headline)
                    .foregroundStyle(
                        MiraiTheme.navy
                    )

                    Text(
                        "\(progressViewModel.currentLevelExperience) XP"
                    )
                    .font(MiraiFonts.caption)
                    .foregroundStyle(
                        MiraiColors.textSecondary
                    )
                }

                Spacer()

                ZStack {

                    Circle()
                        .fill(
                            MiraiColors.softYellow
                        )
                        .frame(
                            width: 54,
                            height: 54
                        )

                    Image(systemName: "star.fill")
                        .font(
                            .system(
                                size: 24,
                                weight: .bold
                            )
                        )
                        .foregroundStyle(
                            MiraiColors.yellow
                        )
                }
            }

            ProgressView(
                value: progressViewModel.levelProgress
            )
            .tint(MiraiColors.matcha)

            HStack {

                Text(
                    "\(progressViewModel.experienceRemaining) XP para el siguiente nivel"
                )
                .font(MiraiFonts.caption)
                .foregroundStyle(
                    MiraiColors.textSecondary
                )

                Spacer()

                Text(
                    "\(progressViewModel.experience) XP"
                )
                .font(MiraiFonts.xp)
                .foregroundStyle(
                    MiraiColors.yellow
                )
            }
        }
        .padding(MiraiTheme.cardPadding)
        .miraiCard(
            background: MiraiColors.card,
            radius: MiraiTheme.largeRadius
        )
    }

    // MARK: - Action Grid

    private var actionGrid: some View {

        LazyVGrid(
            columns: [
                GridItem(
                    .flexible(),
                    spacing: 14
                ),
                GridItem(
                    .flexible(),
                    spacing: 14
                )
            ],
            spacing: 14
        ) {

            NavigationLink {

                KakeboView()

            } label: {

                HomeActionCard(
                    title: "Kakebo",
                    subtitle: "Registra tus gastos",
                    icon: "book.fill",
                    color: MiraiColors.orange
                )
            }

            NavigationLink {

                GoalsView()

            } label: {

                HomeActionCard(
                    title: "Metas",
                    subtitle: "Planea tu futuro",
                    icon: "target",
                    color: MiraiColors.sakura
                )
            }

            NavigationLink {

                KakeboView()

            } label: {

                HomeActionCard(
                    title: "Resumen",
                    subtitle: "Mira tus finanzas",
                    icon: "chart.line.uptrend.xyaxis",
                    color: MiraiColors.matcha
                )
            }

            NavigationLink {

                RewardsView()

            } label: {

                HomeActionCard(
                    title: "Recompensas",
                    subtitle: "Mira tus logros",
                    icon: "trophy.fill",
                    color: MiraiColors.yellow
                )
            }
        }
    }

    // MARK: - Weekly Summary

    private var weeklySummary: some View {

        VStack(
            alignment: .leading,
            spacing: MiraiTheme.mediumSpacing
        ) {

            Text("Esta semana")
                .font(MiraiFonts.headline)
                .foregroundStyle(
                    MiraiTheme.navy
                )

            HStack(spacing: 14) {

                WeeklyAmountCard(
                    title: "Gastado",
                    amount: 850,
                    icon: "arrow.down.circle.fill",
                    color: MiraiColors.orange
                )

                WeeklyAmountCard(
                    title: "Ahorrado",
                    amount: 450,
                    icon: "arrow.up.circle.fill",
                    color: MiraiColors.matcha
                )
            }
        }
    }
}

// MARK: - Home Action Card

private struct HomeActionCard: View {

    let title: String
    let subtitle: String
    let icon: String
    let color: Color

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            ZStack {

                RoundedRectangle(
                    cornerRadius: 14,
                    style: .continuous
                )
                .fill(
                    color.opacity(0.15)
                )
                .frame(
                    width: 48,
                    height: 48
                )

                Image(systemName: icon)
                    .font(
                        .system(
                            size: 21,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(color)
            }

            Text(title)
                .font(MiraiFonts.headline)
                .foregroundStyle(
                    MiraiTheme.navy
                )

            Text(subtitle)
                .font(MiraiFonts.caption)
                .foregroundStyle(
                    MiraiColors.textSecondary
                )
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(MiraiTheme.cardPadding)
        .miraiCard()
    }
}

// MARK: - Weekly Amount Card

private struct WeeklyAmountCard: View {

    let title: String
    let amount: Double
    let icon: String
    let color: Color

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 10
        ) {

            HStack {

                Image(systemName: icon)
                    .font(
                        .system(
                            size: 20,
                            weight: .semibold
                        )
                    )
                    .foregroundStyle(color)

                Spacer()
            }

            Text(title)
                .font(MiraiFonts.caption)
                .foregroundStyle(
                    MiraiColors.textSecondary
                )

            Text(
                amount,
                format: .currency(code: "MXN")
            )
            .font(MiraiFonts.money)
            .foregroundStyle(
                MiraiTheme.navy
            )
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(MiraiTheme.cardPadding)
        .miraiCard()
    }
}

// MARK: - Preview

#Preview {

    HomeView()
        .environment(
            ProgressViewModel()
        )
}
