import SwiftUI

struct GameInfoCard: View {

    let icon: String
    let title: String
    let value: String
    let color: Color

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Image(systemName: icon)
                .font(
                    .system(
                        size: 18,
                        weight: .semibold
                    )
                )
                .foregroundStyle(color)

            Text(title)
                .font(MiraiFonts.caption)
                .foregroundStyle(
                    MiraiColors.textSecondary
                )

            Text(value)
                .font(MiraiFonts.bodyBold)
                .foregroundStyle(
                    MiraiColors.textPrimary
                )
                .lineLimit(2)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(MiraiTheme.cardPadding)
        .miraiCard()
    }
}

#Preview {
    GameInfoCard(
        icon: "tag.fill",
        title: "Categoría",
        value: "Ahorro",
        color: MiraiColors.lavender
    )
    .padding()
    .background(
        MiraiColors.background
    )
}
