import SwiftUI

struct RootView: View {
    @State private var navigationManager = NavigationManager.shared
    
    
    var body: some View {
        ZStack {
            switch navigationManager.currentView {
            case .tab:
                ContentTabView()
                    .environment(navigationManager)
            case .welcome:
                WelcomeView()
            case .splashscreen:
                SplashView()
            }
                
        }
        .environment(navigationManager)
    }
}

