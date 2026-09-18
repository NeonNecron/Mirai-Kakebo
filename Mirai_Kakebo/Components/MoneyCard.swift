import SwiftUI

struct MoneyCard: View {

    let title: String
    let amount: Double
    let icon: String
    let color: Color

    var body: some View {
        HStack(spacing: 14) {

            ZStack {
                Circle()
                    .fill(color.opacity(0.15))
                    .frame(width: 50, height: 50)

                Image(systemName: icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundStyle(color)
            }

            VStack(alignment: .leading, spacing: 4) {

                Text(title)
                    .font(MiraiFonts.caption)
                    .foregroundStyle(MiraiTheme.navy)

                Text(
                    amount,
                    format: .currency(code: "MXN")
                )
                .font(MiraiFonts.money)
                .foregroundStyle(MiraiTheme.navy)
            }

            Spacer()
        }
        .padding(MiraiTheme.cardPadding)
        .background(MiraiColors.card)
        .clipShape(
            RoundedRectangle(
                cornerRadius: MiraiTheme.mediumRadius,
                style: .continuous
            )
        )
        .shadow(
            color: MiraiTheme.navy.opacity(
                MiraiTheme.shadowOpacity
            ),
            radius: MiraiTheme.shadowRadius,
            x: 0,
            y: MiraiTheme.shadowY
        )
    }
}

#Preview {
    MoneyCard(
        title: "Dinero disponible",
        amount: 1250,
        icon: "banknote.fill",
        color: MiraiColors.money
    )
    .padding()
    .background(MiraiColors.background)
}
