import SwiftUI

struct MiraiBackground<Content: View>: View {
    
    let content: Content
    
    init(
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
    }
    
    var body: some View {
        
        ZStack {
            
            MiraiColors.background
                .ignoresSafeArea()
            
            content
        }
    }
}
