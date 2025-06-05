import Foundation
import Observation

@Observable
final class HomeViewModel {
    private let dataRepository: DataRepositoryProtocol
    
    var randomArtObjects: [ArtObjectModel] = []
    var isLoading = false
    
    init(dataRepository: DataRepositoryProtocol = NetworkRepository()) {
        self.dataRepository = dataRepository
    }
    
    func getRandomArtObjects() async {
        guard randomArtObjects.isEmpty else { return }
        do {
            isLoading = true
            randomArtObjects = try await dataRepository.getRandomArtObjectsWithImage(count: 5)
            print("Fetched random art objects: \(randomArtObjects.count)")
            
            isLoading = false
        } catch {
            isLoading = false
            print("Error fetching random art objects: \(error)")
        }
    }

}
    
