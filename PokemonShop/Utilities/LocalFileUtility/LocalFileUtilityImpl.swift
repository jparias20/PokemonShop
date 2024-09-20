import Foundation
import LocalFileManagerFramework

final class LocalFileUtilityImpl {
    static let shared = LocalFileUtilityImpl()
    
    private init() {}
}

extension LocalFileUtilityImpl: LocalFileUtility {
    func fetch(name: String, folderName: String)  async -> Data? {
        await LocalFileManagerFramework.fetch(name: name, folderName: folderName)
    }
    
    func save(_ data: Data, name: String, folderName: String) async {
        await LocalFileManagerFramework.save(data, name: name, folderName: folderName)
    }
}
