import SwiftUI

struct KiriView: View {
    
    // MARK: - Expressions
    
    enum Expression {
        case happy
        case thinking
        case excited
        case wink
        case celebrating
        case sad
        case surprised
        case saving
        
        var assetName: String {
            switch self {
            case .happy:
                return "Happy"
            case .thinking:
                return "Thinking"
            case .excited:
                return "Excited"
            case .wink:
                return "Wink"
            case .celebrating:
                return "Celebrating"
            case .sad:
                return "Sad"
            case .surprised:
                return "Surprised"
            case .saving:
                return "Saving"
            }
        }
    }
    
    // MARK: - Properties
    
    let expression: Expression
    let size: CGFloat
    let animated: Bool
    
    // MARK: - Initializer
    
    init(
        expression: Expression = .happy,
        size: CGFloat = 150,
        animated: Bool = true
    ) {
        self.expression = expression
        self.size = size
        self.animated = animated
    }
    
    // MARK: - Animation
    
    @State private var isAnimating = false
    
    // MARK: - Body
    
    var body: some View {
        Image(expression.assetName)
            .resizable()
            .scaledToFit()
            .frame(
                width: size,
                height: size
            )
            .scaleEffect(
                animated && isAnimating ? 1.05 : 1.0
            )
            .animation(
                animated
                ? .easeInOut(duration: 1.2)
                    .repeatForever(
                        autoreverses: true
                    )
                : nil,
                value: isAnimating
            )
            .onAppear {
                if animated {
                    isAnimating = true
                }
            }
            .accessibilityLabel(
                "Kiri, mascota de Mirai Kakebo"
            )
    }
}

// MARK: - Preview

#Preview("Kiri Feliz") {
    KiriView(
        expression: .happy,
        size: 180
    )
}

#Preview("Kiri Pensando") {
    KiriView(
        expression: .thinking,
        size: 180
    )
}
