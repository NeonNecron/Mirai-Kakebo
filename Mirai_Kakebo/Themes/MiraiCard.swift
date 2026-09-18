import SwiftUI

struct MiraiCardModifier: ViewModifier {
    
    let background: Color
    let radius: CGFloat
    
    func body(content: Content) -> some View {
        
        content
            .background(background)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: radius,
                    style: .continuous
                )
            )
            .shadow(
                color: MiraiColors.primary.opacity(
                    MiraiTheme.shadowOpacity
                ),
                radius: MiraiTheme.shadowRadius,
                x: 0,
                y: MiraiTheme.shadowY
            )
    }
}


extension View {
    
    func miraiCard(
        background: Color = MiraiColors.card,
        radius: CGFloat = MiraiTheme.largeRadius
    ) -> some View {
        
        modifier(
            MiraiCardModifier(
                background: background,
                radius: radius
            )
        )
    }
}
