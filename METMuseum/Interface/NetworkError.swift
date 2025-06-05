import Foundation

enum NetworkError: LocalizedError {
    case notHTTPResponse
    case statusCode(Int)
    case decodingError(Error)
    case unknownError(Error)
    
    var errorDescription: String? {
        switch self {
        case .notHTTPResponse:
            return "The response is not an HTTP response."
        case .statusCode(let code):
            return "Received an unexpected HTTP status code: \(code)."
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .unknownError(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
