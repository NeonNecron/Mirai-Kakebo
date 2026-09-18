import SwiftUI

struct MiraiButton: View {

    let title: String
    let systemImage: String
    var color: Color = MiraiTheme.coral
    var action: () -> Void

    @State private var isPressed = false

    var body: some View {

        Button {
            action()
        } label: {

            HStack(spacing: 12) {

                Image(systemName: systemImage)
                    .font(
                        .system(
                            size: 22,
                            weight: .bold
                        )
                    )

                Text(title)
                    .font(MiraiFonts.headline)
            }
            .foregroundStyle(MiraiColors.card)
            .frame(maxWidth: .infinity)
            .frame(height: MiraiTheme.buttonHeight)
            .background(color)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: MiraiTheme.mediumRadius,
                    style: .continuous
                )
            )
            .shadow(
                color: MiraiTheme.navy.opacity(0.12),
                radius: 6,
                y: 4
            )
            .scaleEffect(isPressed ? 0.97 : 1)
        }
        .buttonStyle(.plain)
        .sensoryFeedback(
            .impact,
            trigger: isPressed
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    withAnimation(
                        .easeOut(duration: 0.1)
                    ) {
                        isPressed = true
                    }
                }
                .onEnded { _ in
                    withAnimation(
                        .spring(response: 0.25)
                    ) {
                        isPressed = false
                    }
                }
        )
        .accessibilityLabel(title)
    }
}

#Preview {

    ZStack {

        MiraiColors.background
            .ignoresSafeArea()

        MiraiButton(
            title: "Ahorrar dinero",
            systemImage: "banknote.fill"
        ) {
            print("Botón presionado")
        }
        .padding()
    }
}
