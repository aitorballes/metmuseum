import SwiftUI
import SwiftData

struct MembershipListView: View {
    @Environment(NavigationManager.self) private var navigationManager
    @Environment(\.modelContext) private var modelContext
    
    @State private var showMembershipView = false
    
    @Query() private var memberships: [MembershipModel]
    
    var body: some View {
        @Bindable var navigationManager = navigationManager
        NavigationStack(path: $navigationManager.cardNavigationPath) {
            List {
                ForEach(memberships) { membership in
                    CardView(model: membership)
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        modelContext.delete(memberships[index])
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Memberships")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showMembershipView.toggle()
                    } label: {
                        Label("Add Membership", systemImage: "plus")
                    }
                }
            }
            .overlay {
                if memberships.isEmpty {
                    ContentUnavailableView("No membership cards", systemImage: "creditcard.fill", description: Text("Tap the '+' button to create a new membership card."))
                }
                        
            }
            .sheet(isPresented: $showMembershipView) {
                MembershipView(
                    viewModel: MembershipViewModel(modelContext: modelContext)
                )
                .presentationDetents([.large])
                .presentationDragIndicator(.visible )
            }
                
            
        }
    }
}

#Preview {
    MembershipListView()
}
