import Foundation

extension URL {
    private static let baseURL = URL(string: "https://collectionapi.metmuseum.org/public/collection/v1")!
    
    static let getAllArtObjectsIds = baseURL.appending(path: "objects")
    static func getArtObjectDetail(objectId: Int) -> URL {
        baseURL.appending(path: "objects/\(objectId)")
    }
    static func searchArtObjects(query: String) -> URL {
        baseURL.appending(path: "search").appending(queryItems: [URLQueryItem(name: "q", value: query.lowercased())])
    }
}
