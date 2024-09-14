import Foundation
import NetworkingFramework

protocol ImageUtility {
    func fetchImage(_ request: HTTPRequest) async throws -> Data
}
