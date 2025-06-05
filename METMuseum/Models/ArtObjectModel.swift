import Foundation

struct ArtObjectModel: Identifiable, Hashable {
    let id: Int
    let title: String
    let artistName: String
    let objectDate: String?
    let image: URL?
    let imageSmall: URL?
}
