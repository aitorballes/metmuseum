import Foundation


protocol NetworkInteractor {
}

extension NetworkInteractor {
    func getData<T>(url: URL, type: T.Type) async throws(NetworkError) -> T where T: Codable {
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.notHTTPResponse
            }
            
            guard httpResponse.statusCode == 200 else {
                print("For the URL \(url) received HTTP status code: \(httpResponse.statusCode)\n")
                throw NetworkError.statusCode(httpResponse.statusCode)
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                return result
            } catch {
                throw NetworkError.decodingError(error)
            }
            
        } catch let error as NetworkError {
            throw error
        } catch {
            throw .unknownError(error)
        }
    }
}

