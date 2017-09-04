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
        let filter = CIFilter(name: Keys.lanczosFilterName)!
        filter.setValue(image, forKey: kCIInputImageKey)
        filter.setValue(1, forKey: kCIInputAspectRatioKey)
        
        let context = CIContext(options: [kCIContextUseSoftwareRenderer: false])
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let iconSet = iconFactory.makeSet(withName: Keys.iconName,
                                             idioms: [.iphone, .ipad, .iosMarketing])
        try iconSet.images.forEach { icon in
            let scale = icon.size * icon.scale / width
            filter.setValue(scale, forKey: kCIInputScaleKey)
            guard let outputImage = filter.value(forKey: kCIOutputImageKey) as? CIImage else {
                throw Error.cantRenderImage
            }
            guard let outputData = context.jpegRepresentation(of: outputImage, colorSpace: colorSpace, options: [:]) else {
                try fileSystem.currentFolder.subfolder(named: Keys.iconSetName).delete()
                throw Error.cantRenderImage
            }
            
            let path = [Keys.iconSetName, icon.filename].joined(separator: "/")
            let file = try fileSystem.createFile(at: path)
            try file.write(data: outputData)
        }
        try writeContents(of: iconSet)
    }
    
    func generateAndroidIcons(for imageURL: URL) throws {
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
        let filter = CIFilter(name: Keys.lanczosFilterName)!
        filter.setValue(image, forKey: kCIInputImageKey)
        filter.setValue(1, forKey: kCIInputAspectRatioKey)
        
        let context = CIContext(options: [kCIContextUseSoftwareRenderer: false])
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        try iconFactory.makeAndroidIcons().forEach { icon in
            let scale = icon.size / width
            filter.setValue(scale, forKey: kCIInputScaleKey)
            guard let outputImage = filter.value(forKey: kCIOutputImageKey) as? CIImage else {
                throw Error.cantRenderImage
            }
            guard let outputData = context.jpegRepresentation(of: outputImage, colorSpace: colorSpace, options: [:]) else {
                try fileSystem.currentFolder.subfolder(named: Keys.androidIconFolder).delete()
                throw Error.cantRenderImage
            }
            
            let path = [Keys.androidIconFolder, icon.name].joined(separator: "/")
            let file = try fileSystem.createFile(at: path)
            try file.write(data: outputData)
        }
    }
    
    func generate(_ icons: [IconRepresentable], folderName: String) throws {
//        let filter = CIFilter(name: Keys.lanczosFilterName)!
//        filter.setValue(image, forKey: kCIInputImageKey)
//        filter.setValue(1, forKey: kCIInputAspectRatioKey)
//        
//        let context = CIContext(options: [kCIContextUseSoftwareRenderer: false])
//        let colorSpace = CGColorSpaceCreateDeviceRGB()
//        
//        try icons.forEach { icon in
//            let scale = icon.size() / width
//            filter.setValue(scale, forKey: kCIInputScaleKey)
//            guard let outputImage = filter.value(forKey: kCIOutputImageKey) as? CIImage else {
//                throw Error.cantRenderImage
//            }
//            guard let outputData = context.jpegRepresentation(of: outputImage, colorSpace: colorSpace, options: [:]) else {
//                try fileSystem.currentFolder.subfolder(named: Keys.androidIconFolder).delete()
//                throw Error.cantRenderImage
//            }
//            
//            let path = [Keys.androidIconFolder, icon.name()].joined(separator: "/")
//            let file = try fileSystem.createFile(at: path)
//            try file.write(data: outputData)
//        }
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
