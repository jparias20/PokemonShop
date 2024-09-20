import Foundation
import NetworkingFramework

protocol NetworkingUtility {
    func sendRequest(request: HTTPRequest) async throws -> Data
    func sendRequest<T: Decodable>(request: HTTPRequest) async throws -> T
}
