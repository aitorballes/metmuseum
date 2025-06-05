import SwiftData
import SwiftUI

@main
struct METMuseumApp: App {
    let modelContainer: ModelContainer = {
        let schema = Schema([
            MembershipModel.self])
        
        let configuration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to create model container: \(error)")
        }
       
    }()

    var body: some Scene {
        WindowGroup {
           RootView()
        }
        .modelContainer(modelContainer)
    }
}
