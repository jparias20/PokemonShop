import Foundation
import NetworkingFramework
import UIKit

final class ImageService: ObservableObject {
    private let localFileUtility: LocalFileUtility
    private let imageUtility: ImageUtility

    init(
        localFileUtility: LocalFileUtility = LocalFileUtilityImpl(),
        imageUtility: ImageUtility = ImageUtilityImpl()
    ) {
        self.localFileUtility = localFileUtility
        self.imageUtility = imageUtility
    }
    
    func fetchImage(folderName: String, dataName: String, request: HTTPRequest) async throws -> UIImage {
        if let data: Data = await localFileUtility.fetch(name: dataName, folderName: folderName),
           let image = UIImage(data: data) {
            return image
        }
        
        let data = try await imageUtility.fetchImage(request)
        guard let image = UIImage(data: data) else { throw ImageServiceError.noImage }
        await localFileUtility.save(data, name: dataName, folderName: folderName)
        return image
    }
}
