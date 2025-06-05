import SwiftUI

struct ContentTabView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "bookmark") {
                HomeView(viewModel: .init())
            }
            
            Tab("Explore", systemImage: "text.magnifyingglass"){
                ArtsObjectsListView(viewModel: .init())
            }
            
            Tab("Cards", systemImage: "creditcard") {
                MembershipListView()
            }
        }
    }
}

#Preview {
    ContentTabView()
}
