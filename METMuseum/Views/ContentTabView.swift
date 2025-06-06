import SwiftUI

struct ContentTabView: View {
    @Environment(NavigationManager.self) private var navigationManager
    
    var body: some View {
        @Bindable var navigationManager = navigationManager
        TabView (selection: $navigationManager.selectedTab) {
            Tab("Home", systemImage: "bookmark", value: .home) {
                HomeView(viewModel: .init())
            }
            
            Tab("Explore", systemImage: "text.magnifyingglass", value: .list){
                ArtsObjectsListView()
            }
            
            Tab("Cards", systemImage: "creditcard", value: .cards) {
                MembershipListView()
            }
        }
    }
}

#Preview {
    ContentTabView()
}
