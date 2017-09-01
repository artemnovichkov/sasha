//
//  IconService.swift
//  Files
//
//  Created by Artem Novichkov on 01/09/2017.
//

import CoreImage
import Files

final class IconService {
    
    enum Error: Swift.Error {
        case cantCreateImage
        case cantGetSize
        case wrongSize
    }
    
    private let iconSetFactory: IconSetFactory
    
    init(iconSetFactory: IconSetFactory = IconSetFactory()) {
        self.iconSetFactory = iconSetFactory
    }
    
    func generateIcons(for url: URL) throws {
        guard let image = CIImage(contentsOf: url) else {
            throw Error.cantCreateImage
        }
        guard let width = image.properties["PixelWidth"] as? CGFloat,
        let height = image.properties["PixelHeight"] as? CGFloat else {
            throw Error.cantGetSize
        }
        guard width == 1024, height == 1024 else {
            throw Error.wrongSize
        }
        let filter = CIFilter(name: "CILanczosScaleTransform")!
        filter.setValue(image, forKey: kCIInputImageKey)
        filter.setValue(1, forKey: kCIInputAspectRatioKey)
        
        let context = CIContext()
        
        iconSetFactory.makeSet(withName: "Icon-App").images.forEach { icon in
            let scale = icon.size * Float(icon.scale) / Float(width)
            filter.setValue(scale, forKey: kCIInputScaleKey)
            let outputImage = filter.value(forKey: kCIOutputImageKey) as! CIImage
            let outputData = context.jpegRepresentation(of: outputImage,
                                                        colorSpace: CGColorSpaceCreateDeviceRGB(),
                                                        options: [:])
            
            let file = try! FileSystem().createFile(at: "AppIcon.appiconset/" + icon.filename)
            try! file.write(data: outputData!)
        }
    }
}

extension IconService.Error: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .cantCreateImage: return "Can't create an image."
        case .cantGetSize: return "Can't get image size."
        case .wrongSize: return "Image has wrong size."
        }
    }
}
