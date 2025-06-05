final class ArtObjectsCache {
    static let general = ArtObjectsCache()
    static let search = ArtObjectsCache()
    
    private(set) var ids: [Int] = []
    private var currentIndex: Int = 0

    func store(ids: [Int]) {
        self.ids = ids
        self.currentIndex = 0
    }

    func getIds(count: Int, getFirsts: Bool = true) -> [Int] {
        guard !ids.isEmpty else { return [] }
        if getFirsts {
            currentIndex = 0
        }
        let startIndex = getFirsts ? currentIndex : currentIndex + count
        let endIndex = min(startIndex + count, ids.count)
        if startIndex >= ids.count { return [] }
        if !getFirsts { currentIndex = startIndex }
        let result = Array(ids[startIndex..<endIndex])
        print("Returning IDs from \(startIndex) to \(endIndex):\n \(result)\n")
        return result
    }
}
