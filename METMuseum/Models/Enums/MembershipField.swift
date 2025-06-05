enum MembershipField {
    case firstName
    case email

    var previous: MembershipField? {
        switch self {
        case .firstName: nil
        case .email: .firstName
        }
    }

    var next: MembershipField? {
        switch self {
        case .firstName: .email
        case .email: nil
        }
    }
}
