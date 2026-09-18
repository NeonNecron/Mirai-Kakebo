import SwiftUI

struct ProgressBar: View {

    let progress: Double

    var color: Color = MiraiTheme.green

    private var safeProgress: Double {
        min(max(progress, 0), 1)
    }

    var body: some View {

        GeometryReader { geometry in

            ZStack(alignment: .leading) {

                Capsule()
                    .fill(
                        MiraiTheme.navy.opacity(0.10)
                    )

                Capsule()
                    .fill(color)
                    .frame(
                        width: geometry.size.width * safeProgress
                    )
                    .animation(
                        .spring(response: 0.5),
                        value: safeProgress
                    )
            }
        }
        .frame(height: 14)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Progreso")
        .accessibilityValue(
            "\(Int(safeProgress * 100)) por ciento"
        )
    }
}

#Preview {

    VStack(spacing: 20) {

        ProgressBar(
            progress: 0.6,
            color: MiraiTheme.green
        )

        ProgressBar(
            progress: 0.35,
            color: MiraiTheme.lavender
        )
    }
    .padding()
    .background(MiraiColors.background)
}
