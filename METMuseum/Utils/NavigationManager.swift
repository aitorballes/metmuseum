import SwiftUI

@Observable
final class NavigationManager {
    static let shared = NavigationManager()
    
    var currentView: AppView
    var selectedTab: TabItem
    var listNavigationPath: NavigationPath
    var cardNavigationPath: NavigationPath
    var isModalPresented = false
    
    init(currentView: AppView = .splashscreen, selectedTab: TabItem = .home, listNavigationPath: NavigationPath = .init(), cardNavigationPath: NavigationPath = .init()) {
        self.currentView = currentView
        self.selectedTab = selectedTab
        self.listNavigationPath = listNavigationPath
        self.cardNavigationPath = cardNavigationPath
    }
}

enum AppView{
    case splashscreen
    case welcome
    case tab
}

enum TabItem {
    case home
    case list
    case cards
}
    
