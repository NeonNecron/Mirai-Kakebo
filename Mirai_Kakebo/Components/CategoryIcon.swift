import SwiftUI

struct CategoryIcon: View {
    
    let category: Category
    let size: CGFloat
    
    init(
        category: Category,
        size: CGFloat = 52
    ) {
        self.category = category
        self.size = size
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(
                cornerRadius: MiraiTheme.smallRadius,
                style: .continuous
            )
            .fill(category.color.opacity(0.15))
            
            Text(category.emoji)
                .font(.system(size: size * 0.48))
        }
        .frame(
            width: size,
            height: size
        )
    }
}
