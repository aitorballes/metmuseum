import Foundation

struct NetworkRepository: DataRepositoryProtocol, NetworkInteractor {

    private let cache = ArtObjectsCache.general
    private let searchCache = ArtObjectsCache.search
    private let maxResults = 20
    
    func getObjectIds(getFirsts: Bool = true) async throws -> [Int] {
        if cache.ids.isEmpty {
            let response = try await getData(
                url: .getAllArtObjectsIds,
                type: ArtObjectsResponseDTO.self
            )
            let allIds = response.objectIDs ?? []
            cache.store(ids: allIds)
        }
        return cache.getIds(count: maxResults, getFirsts: getFirsts)
    }

    func getArtObjects() async throws -> [ArtObjectModel] {
        guard let objectIds = try? await getObjectIds(getFirsts: true),
            !objectIds.isEmpty
        else {
            return []
        }
        return try await getArtObjectsByIds(ids: objectIds)
    }

    func seachArtObjects(query: String) async throws -> [ArtObjectModel] {
        guard
            let objectIds = try? await getSearchObjectIds(
                query: query,
                getFirsts: true
            ),
            !objectIds.isEmpty
        else {
            return []
        }
        return try await getArtObjectsByIds(ids: objectIds)
    }

    func getNextArtObjects(isSearch: Bool = false) async throws
        -> [ArtObjectModel]
    {
        let objectIds = isSearch
            ? try await getSearchObjectIds(query: "", getFirsts: false)
            : try await getObjectIds(getFirsts: false)

        return try await getArtObjectsByIds(ids: objectIds)
    }
    
    
    func getRandomArtObjectsWithImage(count: Int = 5) async throws -> [ArtObjectModel] {
        if cache.ids.isEmpty {
            let response = try await getData(
                url: .getAllArtObjectsIds,
                type: ArtObjectsResponseDTO.self
            )
            let allIds = response.objectIDs ?? []
            cache.store(ids: allIds)
        }

        var allIds = cache.ids
        allIds.shuffle()

        var result: [ArtObjectModel] = []
        
        for id in allIds {
            if result.count >= count { break }
            print("Fetching art object with ID: \(id)")
            
            if let artObject = try? await getArtObject(by: id),
               artObject.image != nil {
                print("Art object with ID \(id) has an image.")
                result.append(artObject)
            }else{
                print("Art object with ID \(id) does not have an image.")
            }
        }

        return result
    }

}

extension NetworkRepository {

    private func getArtObjectsByIds(ids: [Int]) async throws
        -> [ArtObjectModel]
    {
        guard !ids.isEmpty else { return [] }
        var artObjects: [ArtObjectModel] = []
        
        try await withThrowingTaskGroup(of: ArtObjectModel?.self) { group in
            for id in ids {
                group.addTask {
                    try? await self.getArtObject(by: id)
                }
            }
            for try await artObject in group {
                if let artObject = artObject {
                    artObjects.append(artObject)
                }
            }
        }
        return artObjects
    }

    private func getSearchObjectIds(query: String, getFirsts: Bool = true)
        async throws -> [Int]
    {

        if getFirsts {
            let response = try await getData(
                url: .searchArtObjects(query: query),
                type: ArtObjectsResponseDTO.self
            )
            let allIds = response.objectIDs ?? []
            searchCache.store(ids: allIds)
        }

        return searchCache.getIds(count: maxResults, getFirsts: getFirsts)
    }

    private func getArtObject(by objectId: Int) async throws
        -> ArtObjectModel
    {
        try await getData(
            url: .getArtObjectDetail(objectId: objectId),
            type: ArtObjectDTO.self
        ).toModel()
    }
}
