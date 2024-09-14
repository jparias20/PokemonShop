import Foundation
import NetworkingFramework

final class ImageUtilityImpl {
    private let httpClient: HTTPClient

    init(httpClient: HTTPClient = HTTPClientImpl()) { self.httpClient = httpClient }
}

extension ImageUtilityImpl: ImageUtility {
    func fetchImage(_ request: HTTPRequest) async throws -> Data {
        try await httpClient.sendRequest(request: request)
    }
}
