//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//
import CoreImage
import Files

final class IconService {
    
    enum Error: Swift.Error {
        case imageCreationFailed
        case sizeReadingFailed
        case wrongSizeDetected
        case imageRenderingFailed
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
    
    /// Generates icons for iOS platform.
    ///
    /// - Parameter imageURL: The url for original image.
    /// - Throws: `IconService.Error` errors.
    func generateIcons(for imageURL: URL) throws {
        let image = try self.image(for: imageURL)
        let iconSet = iconFactory.makeSet(withName: Keys.iconName,
                                          idioms: [.iphone, .ipad, .iosMarketing])
        try generateIcons(from: image, icons: iconSet.images, folderName: Keys.iconSetName)
        try writeContents(of: iconSet)
    }
    
    /// Generates icons for Android platform.
    ///
    /// - Parameter imageURL: The url for original image.
    /// - Throws: `IconService.Error` errors.
    func generateAndroidIcons(for imageURL: URL) throws {
        let image = try self.image(for: imageURL)
        try generateIcons(from: image,
                          icons: iconFactory.makeAndroidIcons(),
                          folderName: Keys.androidIconFolder)
    }
    
    private func image(for imageURL: URL) throws -> CIImage {
        guard let image = CIImage(contentsOf: imageURL) else {
            throw Error.imageCreationFailed
        }
        guard let width = image.properties[Keys.width] as? Float,
            let height = image.properties[Keys.height] as? Float else {
                throw Error.sizeReadingFailed
        }
        guard width == 1024, height == 1024 else {
            throw Error.wrongSizeDetected
        }
        return image
    }
    
    /// Generates icons from original image. The image is resized and written to image files.
    ///
    /// - Parameters:
    ///   - image: The original image.
    ///   - icons: The array of objects, that represent icon information.
    ///   - folderName: The name of folder for generated icons.
    /// - Throws: `IconService.Error` errors.
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
                throw Error.imageRenderingFailed
            }
            guard let outputData = context.jpegRepresentation(of: outputImage, colorSpace: colorSpace, options: [:]) else {
                try fileSystem.currentFolder.subfolder(named: folderName).delete()
                throw Error.imageRenderingFailed
            }
            
            let path = [folderName, icon.iconName()].joined(separator: "/")
            let file = try fileSystem.createFile(at: path)
            try file.write(data: outputData)
        }
    }
    
    /// Writes `Contents.json` file that contains names of icons.
    ///
    /// - Parameter set: The set with icons.
    /// - Throws: `File.Error.writeFailed` if the file couldn’t be written to.
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
        case .imageCreationFailed: return "Can't create an image."
        case .sizeReadingFailed: return "Can't get image size."
        case .wrongSizeDetected: return "Image has wrong size."
        case .imageRenderingFailed: return "Can't render the image."
        }
    }
}
