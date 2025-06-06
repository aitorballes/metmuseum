import Foundation
import Observation

@Observable
final class ArtObjectsViewModel {
    private let dataRepository: DataRepositoryProtocol
    
    var artObjects: [ArtObjectModel] = []
    var searchObjects: [ArtObjectModel] = []
    var displayedObjects: [ArtObjectModel] = []
    var isLoading = false
    var searchTask: Task<Void, Error>?
    
    var searchQuery: String = "" {
        didSet {
            Task {
                await search()
            }
        }
    }
    
    func search() async {
        if searchTask != nil{
            searchTask?.cancel()
            searchTask = nil
        }
        
        searchTask = Task {
            try await Task.sleep(for: .seconds(0.5))
            
            if !Task.isCancelled {
                await searchArtObjects()
            }
        }
    }    
    
    init(dataRepository: DataRepositoryProtocol = NetworkRepository()) {
        self.dataRepository = dataRepository
        
        Task {
            await firstLoad()
        }
    }
    
    func firstLoad() async {
        do {
          _ = try await dataRepository.getObjectIds(getFirsts: true)
            
        } catch {
            print("Error fetching object IDs: \(error)")
        }
    }
    
    func getArtObjects() async {
        do {
            isLoading = true
            artObjects = try await dataRepository.getArtObjects()
            displayedObjects = artObjects
            isLoading = false
        } catch {
            isLoading = false
            print("Error fetching art objects: \(error)")
        }
    }
    
    func searchArtObjects() async {
        do {
            if searchQuery.isEmpty {
                displayedObjects = artObjects
                return
            }
            
            isLoading = true
            searchObjects = try await dataRepository.searchArtObjects(query: searchQuery)
            displayedObjects = searchObjects
            isLoading = false
        } catch {
            isLoading = false
            print("Error searching art objects: \(error)")
        }
    }
    
    func loadMoreObjects() async {
        do {
            isLoading = true
            let newObjects = try await dataRepository.getNextArtObjects(isSearch: !searchQuery.isEmpty)
            displayedObjects.append(contentsOf: newObjects)
            isLoading = false
        } catch {
            print("Error loading more art objects: \(error)")
        }
    }
}
        
