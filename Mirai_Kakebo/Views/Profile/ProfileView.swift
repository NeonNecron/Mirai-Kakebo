import SwiftUI

struct ProfileView: View {

    @Environment(ProgressViewModel.self)
    private var progressViewModel

    @Environment(AccessibilitySettings.self)
    private var accessibilitySettings

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(spacing: 24) {

                    // MARK: - Avatar

                    ZStack {

                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [
                                        MiraiColors.softLavender,
                                        MiraiColors.softMatcha
                                    ],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(
                                width: 120,
                                height: 120
                            )

                        Text("🦊")
                            .font(.system(size: 65))
                    }

                    Text("Mi perfil")
                        .font(MiraiFonts.title)

                    Text("¡Sigue aprendiendo con Mirai!")
                        .font(MiraiFonts.body)
                        .foregroundStyle(
                            MiraiColors.textSecondary
                        )

                    // MARK: - Progress

                    VStack(
                        alignment: .leading,
                        spacing: 12
                    ) {

                        Text("Mi progreso")
                            .font(MiraiFonts.headline)

                        HStack {

                            Text("Nivel")

                            Spacer()

                            Text(
                                "\(progressViewModel.level)"
                            )
                            .fontWeight(.bold)
                        }

                        ProgressView(
                            value: progressViewModel.levelProgress
                        )
                        .tint(MiraiColors.primary)

                        HStack {

                            Text(
                                "\(progressViewModel.experience) XP"
                            )

                            Spacer()

                            Text(
                                "\(progressViewModel.experienceForNextLevel) XP"
                            )
                            .foregroundStyle(.secondary)
                        }
                        .font(MiraiFonts.caption)
                    }
                    .padding()
                    .miraiCard()

                    // MARK: - Statistics

                    HStack(spacing: 12) {

                        ProfileStatistic(
                            value: "\(progressViewModel.completedGames)",
                            title: "Juegos",
                            icon: "gamecontroller.fill"
                        )

                        ProfileStatistic(
                            value: "\(progressViewModel.completedLessons)",
                            title: "Lecciones",
                            icon: "book.fill"
                        )

                        ProfileStatistic(
                            value: "\(progressViewModel.coins)",
                            title: "Monedas",
                            icon: "circle.fill"
                        )
                    }

                    // MARK: - Accessibility

                    VStack(
                        alignment: .leading,
                        spacing: 16
                    ) {

                        // Header

                        HStack(spacing: 12) {

                            Image(
                                systemName: "accessibility"
                            )
                            .font(
                                .system(
                                    size: 22,
                                    weight: .semibold
                                )
                            )
                            .foregroundStyle(
                                MiraiColors.lavender
                            )

                            VStack(
                                alignment: .leading,
                                spacing: 4
                            ) {

                                Text("Accesibilidad")
                                    .font(
                                        MiraiFonts.headline
                                    )

                                Text(
                                    "Personaliza la apariencia de Mirai Kakebo."
                                )
                                .font(
                                    MiraiFonts.caption
                                )
                                .foregroundStyle(
                                    MiraiColors.textSecondary
                                )
                            }
                        }

                        Divider()

                        // Color Filter

                        VStack(
                            alignment: .leading,
                            spacing: 12
                        ) {

                            HStack {

                                Image(
                                    systemName:
                                        "paintpalette.fill"
                                )
                                .foregroundStyle(
                                    MiraiColors.lavender
                                )

                                Text("Filtro de color")
                                    .font(
                                        MiraiFonts.bodyBold
                                    )

                                Spacer()
                            }

                            Picker(
                                "Filtro de color",
                                selection: Bindable(
                                    accessibilitySettings
                                ).colorFilter
                            ) {

                                ForEach(
                                    ColorFilter.allCases
                                ) { filter in

                                    HStack {

                                        Image(
                                            systemName:
                                                filter.systemImage
                                        )

                                        Text(
                                            filter.title
                                        )
                                    }
                                    .tag(filter)
                                }
                            }
                            .pickerStyle(.menu)

                            // Información del filtro

                            HStack(
                                alignment: .top,
                                spacing: 10
                            ) {

                                Image(
                                    systemName:
                                        accessibilitySettings
                                            .colorFilter
                                            .systemImage
                                )
                                .foregroundStyle(
                                    MiraiColors.lavender
                                )

                                Text(
                                    accessibilitySettings
                                        .colorFilter
                                        .description
                                )
                                .font(
                                    MiraiFonts.caption
                                )
                                .foregroundStyle(
                                    MiraiColors.textSecondary
                                )
                                .fixedSize(
                                    horizontal: false,
                                    vertical: true
                                )
                            }
                            .padding(12)
                            .background(
                                MiraiColors.softLavender
                            )
                            .clipShape(
                                RoundedRectangle(
                                    cornerRadius: 14,
                                    style: .continuous
                                )
                            )
                        }

                        // Reset

                        if accessibilitySettings.colorFilter
                            != .normal {

                            Button {

                                withAnimation {

                                    accessibilitySettings
                                        .resetAccessibilitySettings()
                                }

                            } label: {

                                HStack {

                                    Image(
                                        systemName:
                                            "arrow.counterclockwise"
                                    )

                                    Text(
                                        "Restablecer filtro"
                                    )
                                    .font(
                                        MiraiFonts.bodyBold
                                    )

                                    Spacer()
                                }
                                .foregroundStyle(
                                    MiraiColors.primary
                                )
                            }
                            .buttonStyle(.plain)
                            .accessibilityLabel(
                                "Restablecer filtro de color"
                            )
                        }
                    }
                    .padding(MiraiTheme.cardPadding)
                    .miraiCard(
                        background:
                            MiraiColors.secondaryBackground
                    )
                }
                .padding()
            }
            .background(
                MiraiColors.background
                    .ignoresSafeArea()
            )
            .navigationTitle("Mi perfil")
        }
    }
}

// MARK: - Profile Statistic

struct ProfileStatistic: View {

    let value: String
    let title: String
    let icon: String

    var body: some View {

        VStack(spacing: 8) {

            Image(systemName: icon)
                .foregroundStyle(
                    MiraiColors.primary
                )

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
    }
}

// MARK: - Preview

#Preview {

    ProfileView()
        .environment(
            ProgressViewModel()
        )
        .environment(
            AccessibilitySettings()
        )
}
