//
//  IconService.swift
//  Files
//
//  Created by Artem Novichkov on 01/09/2017.
//

import CoreImage

final class IconService {
    
    enum Error: Swift.Error {
        case cantCreateImage
        case cantGetSize
    }
    
    func generateIcons(for url: URL) throws {
        guard let image = CIImage(contentsOf: url) else {
            throw Error.cantCreateImage
        }
        guard let width = image.properties["PixelWidth"] as? CGFloat,
        let height = image.properties["PixelHeight"] as? CGFloat else {
            throw Error.cantGetSize
        }
        let size = CGSize(width: width, height: height)
        print(size)
    }
}

extension IconService.Error: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .cantCreateImage: return "Can't create an image."
        case .cantGetSize: return "Can't get image size."
        }
    }
}
