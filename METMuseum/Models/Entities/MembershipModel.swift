import SwiftData
import Foundation

@Model
final class MembershipModel {
    @Attribute(.unique) var id: UUID = UUID()
    var firstName: String
    var email: String
    var membershipType: String
    var qrImageData: Data?

    init(firstName: String, email: String, membershipType: String) {
        self.firstName = firstName
        self.email = email
        self.membershipType = membershipType
        self.qrImageData = qrImageData
    }

    var fullData: String {
        return
            "First Name: \(firstName), Email: \(email), Membership Type: \(membershipType)"
    }
    
    var metNumber: String {
        return "MET-\(id.uuidString.prefix(8))"
    }
}
