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
        case cantRenderImage
    }
    
    private enum Keys {
        static let width = "PixelWidth"
        static let height = "PixelHeight"
        static let lanczosFilterName = "CILanczosScaleTransform"
        static let iconName = "Icon-App"
        static let iconSetName = "AppIcon.appiconset"
        static let contentsName = "Contents.json"
        static let androidIconFolder = "android"
        static let androidIconName = "ic_launcher.png"
    }
    
    private let iconFactory: IconFactory
    private let fileSystem: FileSystem
    private let encoder: JSONEncoder
    
    init(iconFactory: IconFactory = IconFactory(),
         fileSystem: FileSystem = FileSystem(),
         encoder: JSONEncoder = JSONEncoder()) {
        self.iconFactory = iconFactory
        self.fileSystem = fileSystem
        self.encoder = encoder
    }
    
    func generateIcons(for imageURL: URL) throws {
        let image = try self.image(for: imageURL)
        let iconSet = iconFactory.makeSet(withName: Keys.iconName,
                                          idioms: [.iphone, .ipad, .iosMarketing])
        try generateIcons(from: image, icons: iconSet.images, folderName: Keys.iconSetName)
        try writeContents(of: iconSet)
    }
    
    func generateAndroidIcons(for imageURL: URL) throws {
        let image = try self.image(for: imageURL)
        try generateIcons(from: image, icons: iconFactory.makeAndroidIcons(), folderName: Keys.androidIconFolder)
    }
    
    private func image(for imageURL: URL) throws -> CIImage {
        guard let image = CIImage(contentsOf: imageURL) else {
            throw Error.cantCreateImage
        }
        guard let width = image.properties[Keys.width] as? Float,
            let height = image.properties[Keys.height] as? Float else {
                throw Error.cantGetSize
        }
        guard width == 1024, height == 1024 else {
            throw Error.wrongSize
        }
        return image
    }
    
    private func generateIcons(from image: CIImage, icons: [IconRepresentable], folderName: String) throws {
        let filter = CIFilter(name: Keys.lanczosFilterName)!
        filter.setValue(image, forKey: kCIInputImageKey)
        filter.setValue(1, forKey: kCIInputAspectRatioKey)
        
        let context = CIContext(options: [kCIContextUseSoftwareRenderer: false])
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        try icons.forEach { icon in
            let scale = icon.iconSize() / 1024
            filter.setValue(scale, forKey: kCIInputScaleKey)
            guard let outputImage = filter.value(forKey: kCIOutputImageKey) as? CIImage else {
                throw Error.cantRenderImage
            }
            guard let outputData = context.jpegRepresentation(of: outputImage, colorSpace: colorSpace, options: [:]) else {
                try fileSystem.currentFolder.subfolder(named: folderName).delete()
                throw Error.cantRenderImage
            }
            
            let path = [folderName, icon.iconName()].joined(separator: "/")
            let file = try fileSystem.createFile(at: path)
            try file.write(data: outputData)
        }
    }
    
    private func writeContents(of set: IconSet) throws {
        encoder.outputFormatting = .prettyPrinted
        let iconSetData = try encoder.encode(set)
        let contentsFile = try fileSystem.createFile(at: Keys.iconSetName + "/" + Keys.contentsName)
        try contentsFile.write(data: iconSetData)
    }
}

extension IconService.Error: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .cantCreateImage: return "Can't create an image."
        case .cantGetSize: return "Can't get image size."
        case .wrongSize: return "Image has wrong size."
        case .cantRenderImage: return "Can't render the image."
        }
    }
}
