import Foundation

protocol LocalFileUtility {
    func fetch(name: String, folderName: String) async -> Data?
    func save(_ data: Data, name: String, folderName: String) async
}
