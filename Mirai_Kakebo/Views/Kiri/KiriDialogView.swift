import SwiftUI

struct KiriDialogueView: View {
    
    let message: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            Image(systemName: "sparkles")
                .font(.title3)
                .foregroundStyle(MiraiColors.primary)
            
            Text(message)
                .font(MiraiFonts.body)
                .foregroundStyle(MiraiColors.textPrimary)
                .multilineTextAlignment(.leading)
            
            Spacer(minLength: 0)
        }
        .padding()
        .background(
            MiraiColors.card
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 18
            )
        )
        .shadow(
            color: .black.opacity(0.06),
            radius: 6,
            y: 3
        )
    }
}
