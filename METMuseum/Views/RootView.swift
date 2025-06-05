import SwiftUI

struct RootView: View {
    @State private var navigationManager = NavigationManager.shared
    
    var body: some View {
        ZStack {
            switch navigationManager.currentPath {
            case .home:
                ContentTabView()
            case .welcome:
                WelcomeView()
            case .splashscreen:
                SplashView()
            }
                
        }
        .environment(navigationManager)
    }
}

