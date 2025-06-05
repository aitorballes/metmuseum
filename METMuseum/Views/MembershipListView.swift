import SwiftUI
import SwiftData

struct MembershipListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query() private var memberships: [MembershipModel]
    @State private var showMembershipView = false
    
    var body: some View {
        NavigationStack {
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
