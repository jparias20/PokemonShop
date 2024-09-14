import Foundation
import LocalFileManagerFramework

final class LocalFileUtilityImpl {}

extension LocalFileUtilityImpl: LocalFileUtility {
    func fetch(name: String, folderName: String)  async -> Data? {
        await LocalFileManagerFramework.fetch(name: name, folderName: folderName)
    }
    
    func save(_ data: Data, name: String, folderName: String) async {
        await LocalFileManagerFramework.save(data, name: name, folderName: folderName)
    }
}
