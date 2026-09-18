import SwiftUI

struct LessonDetailView: View {

    @Environment(ProgressViewModel.self)
    private var progressViewModel

    let lesson: Lesson

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

                        Text(lesson.emoji)
                            .font(.system(size: 48))

                        Spacer()

                        VStack(
                            alignment: .trailing,
                            spacing: 4
                        ) {

                            Text("+\(lesson.xpReward) XP")
                                .font(MiraiFonts.xp)
                                .foregroundStyle(
                                    MiraiColors.gold
                                )

                            Text("\(lesson.duration) min")
                                .font(MiraiFonts.captionBold)
                                .foregroundStyle(
                                    MiraiColors.textSecondary
                                )
                        }
                    }

                    Text(lesson.title)
                        .font(MiraiFonts.display)
                        .foregroundStyle(
                            MiraiColors.textPrimary
                        )

                    Text(lesson.description)
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

                // MARK: - Lesson Content

                VStack(
                    alignment: .leading,
                    spacing: MiraiTheme.mediumSpacing
                ) {

                    HStack(spacing: 10) {

                        Image(systemName: "book.fill")
                            .foregroundStyle(
                                MiraiColors.education
                            )

                        Text("Aprende")
                            .font(MiraiFonts.headline)
                            .foregroundStyle(
                                MiraiColors.textPrimary
                            )
                    }

                    Text(lesson.content)
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

                // MARK: - Lesson Information

                HStack(spacing: 12) {

                    LessonInfoCard(
                        icon: "clock.fill",
                        title: "Duración",
                        value: "\(lesson.duration) min",
                        color: MiraiColors.orange
                    )

                    LessonInfoCard(
                        icon: "star.fill",
                        title: "Experiencia",
                        value: "+\(lesson.xpReward) XP",
                        color: MiraiColors.yellow
                    )
                }

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

                        Text("¡Lección completada!")
                            .font(MiraiFonts.headline)
                            .foregroundStyle(
                                MiraiColors.textPrimary
                            )

                        Text(
                            "Has ganado \(lesson.xpReward) XP"
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
                        title: "Completar lección",
                        systemImage: "checkmark.circle.fill",
                        color: MiraiColors.matcha
                    ) {

                        withAnimation {

                            progressViewModel.addXP(
                                lesson.xpReward
                            )

                            progressViewModel.completeLesson()

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
        .navigationTitle("Lección")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        LessonDetailView(
            lesson: Lesson(
                title: "¿Qué es el Kakebo?",
                description: "Aprende los fundamentos del método Kakebo.",
                content: "El Kakebo es un método japonés para organizar el dinero, registrar gastos y aprender a tomar mejores decisiones financieras.",
                emoji: "📖",
                duration: 5,
                xpReward: 100
            )
        )
        .environment(
            ProgressViewModel()
        )
    }
}

