import Foundation

struct ArtObjectDTO: Codable {
    let objectID: Int
    let isHighlight: Bool
    let accessionNumber: String
    let accessionYear: String
    let isPublicDomain: Bool
    let primaryImage: String
    let primaryImageSmall: String
    let additionalImages: [String]
    let department: String
    let objectName: String
    let title: String
    let culture: String
    let period: String
    let dynasty: String
    let reign: String
    let portfolio: String
    let artistRole: String
    let artistPrefix: String
    let artistDisplayName: String
    let artistDisplayBio: String
    let artistSuffix: String
    let artistAlphaSort: String
    let artistNationality: String
    let artistBeginDate: String
    let artistEndDate: String
    let artistGender: String
    let artistWikidataURL: String
    let artistULANURL: String
    let objectDate: String
    let objectBeginDate: Int
    let objectEndDate: Int
    let medium: String
    let dimensions: String
    let creditLine: String
    let geographyType: String
    let city: String
    let state: String
    let county: String
    let country: String
    let region: String
    let subregion: String
    let locale: String
    let locus: String
    let excavation: String
    let river: String
    let classification: String
    let rightsAndReproduction: String
    let linkResource: String
    let metadataDate: String
    let repository: String
    let objectURL: String
    let objectWikidataURL: String
    let isTimelineWork: Bool
    let galleryNumber: String    
}

extension ArtObjectDTO {
    enum CodingKeys: String, CodingKey {
        case objectID, isHighlight, accessionNumber, accessionYear, isPublicDomain, primaryImage, primaryImageSmall, additionalImages, department, objectName, title, culture, period, dynasty, reign, portfolio, artistRole, artistPrefix, artistDisplayName, artistDisplayBio, artistSuffix, artistAlphaSort, artistNationality, artistBeginDate, artistEndDate, artistGender
        case artistWikidataURL = "artistWikidata_URL", artistULANURL = "artistULAN_URL"
        case objectDate, objectBeginDate, objectEndDate, medium, dimensions, creditLine, geographyType, city, state, county, country, region, subregion, locale, locus, excavation, river, classification, rightsAndReproduction, linkResource, metadataDate, repository, objectURL
        case objectWikidataURL = "objectWikidata_URL", isTimelineWork, galleryNumber = "GalleryNumber"
    }
}


extension ArtObjectDTO {
    func toModel() -> ArtObjectModel {
        return ArtObjectModel(
            id: self.objectID,
            title: self.title,
            artistName: self.artistDisplayName,
            objectDate: self.objectDate,
            image: URL(string: self.primaryImage) ?? nil,
            imageSmall: URL(string: self.primaryImageSmall) ?? nil

        )
    }
}
