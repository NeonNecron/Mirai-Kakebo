import SwiftUI

struct MainTabView: View {
    
    @State private var progressViewModel = ProgressViewModel()
    @State private var kiriManager = KiriManager()
    
    var body: some View {
        
        TabView {
            
            // MARK: - Inicio
            
            HomeView()
                .tabItem {
                    Label(
                        "Inicio",
                        systemImage: "house.fill"
                    )
                }
            
            // MARK: - Kakebo
            
            KakeboView()
                .tabItem {
                    Label(
                        "Kakebo",
                        systemImage: "yensign.circle.fill"
                    )
                }
            
            // MARK: - Juegos
            
            GamesView()
                .tabItem {
                    Label(
                        "Juegos",
                        systemImage: "gamecontroller.fill"
                    )
                }
            
            // MARK: - Premios
            
            RewardsView()
                .tabItem {
                    Label(
                        "Premios",
                        systemImage: "trophy.fill"
                    )
                }
            
            // MARK: - Perfil
            
            ProfileView()
                .tabItem {
                    Label(
                        "Perfil",
                        systemImage: "person.fill"
                    )
                }
        }
        .tint(MiraiColors.primary)
        .environment(progressViewModel)
        .environment(kiriManager)
    }
}

#Preview {
    MainTabView()
}
