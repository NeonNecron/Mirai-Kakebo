import SwiftUI

struct KiriCompanionView: View {
    
    let expression: KiriView.Expression
    let message: String
    
    var size: CGFloat = 110
    
    var body: some View {
        VStack(spacing: 12) {
            
            KiriView(
                expression: expression,
                size: size,
                animated: true
            )
            
            KiriDialogueView(
                message: message
            )
        }
    }
}
