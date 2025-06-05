import Foundation

protocol DataRepositoryProtocol {
    func getObjectIds(getFirsts: Bool) async throws -> [Int]
    func getArtObjects() async throws -> [ArtObjectModel]
    func seachArtObjects(query: String) async throws -> [ArtObjectModel]
    func getNextArtObjects(isSearch: Bool) async throws -> [ArtObjectModel]
    func getRandomArtObjectsWithImage(count: Int) async throws -> [ArtObjectModel]
}
