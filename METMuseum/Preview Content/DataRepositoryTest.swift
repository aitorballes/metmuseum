import Foundation

struct DataRepositoryTest: DataRepositoryProtocol {
    func getObjectIds(getFirsts: Bool) async throws -> [Int] {
        []
    }
    
    func getRandomArtObjectsWithImage(count: Int) async throws -> [ArtObjectModel] {
        try getData(filename: "art_objects_preview", type: [ArtObjectDTO].self).map { $0.toModel() }
    }
    
    func getNextArtObjects(isSearch: Bool) async throws -> [ArtObjectModel] {
        try getData(filename: "art_objects_preview", type: [ArtObjectDTO].self).map { $0.toModel() }
    }
    
    func getArtObjects() async throws -> [ArtObjectModel] {
        try getData(filename: "art_objects_preview", type: [ArtObjectDTO].self).map { $0.toModel() }
    }
    
    func seachArtObjects(query: String) async throws -> [ArtObjectModel] {
        try getData(filename: "art_objects_preview", type: [ArtObjectDTO].self).map { $0.toModel() }
    }
    

    private func getData<Model>(filename: String, type: Model.Type) throws
        -> Model where Model: Decodable
    {
        let url = Bundle.main.url(forResource: filename, withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(type, from: data)
    }
}
