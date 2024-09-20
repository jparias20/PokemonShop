import Foundation
import NetworkingFramework

final class HTTPClientProvider: NetworkingUtility {
    static let shared = HTTPClientProvider()
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient = HTTPClientImpl()) {
        self.httpClient = httpClient
    }
    
    func sendRequest(request: HTTPRequest) async throws -> Data {
        try await httpClient.sendRequest(request: request)
    }
    
    func sendRequest<T: Decodable>(request: HTTPRequest) async throws -> T {
        try await httpClient.sendRequest(request: request)
    }
}
