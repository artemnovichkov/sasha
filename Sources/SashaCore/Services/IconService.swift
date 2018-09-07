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
        static let defaultSize: Float = 1024
    }

    private let iconFactory: IconFactory
    private let fileSystem: FileSystem
    private let encoder: JSONEncoder

    init(iconFactory: IconFactory = .init(),
         fileSystem: FileSystem = .init(),
         encoder: JSONEncoder = .init()) {
        self.iconFactory = iconFactory
        self.fileSystem = fileSystem
        self.encoder = encoder
    }

    /// Generates icons for iOS platform.
    ///
    /// - Parameter imageURL: The url for original image.
    /// - Parameter idioms: Idioms for additional icons. Default value is nil.
    /// - Parameter output: Output path for generated icons. Default value is nil.
    /// - Throws: `IconService.Error` errors.
    func generateiOSIcons(for imageURL: URL, idioms: [Icon.Idiom]? = nil, output: String? = nil) throws {
        var fullIdioms: [Icon.Idiom] = [.iphone, .ipad, .iosMarketing]
        if let idioms = idioms {
            fullIdioms.append(contentsOf: idioms)
        }
        try generateIcons(for: imageURL, idioms: fullIdioms, output: output)
    }

    /// Generates icons for macOS platform.
    ///
    /// - Parameter imageURL: The url for original image.
    /// - Parameter output: Output path for generated icons. Default value is nil.
    /// - Throws: `IconService.Error` errors.
    func generateMacOSIcons(for imageURL: URL, output: String? = nil) throws {
        try generateIcons(for: imageURL, idioms: [.mac], output: output)
    }

    /// Generates icons for watchOS platform.
    ///
    /// - Parameter imageURL: The url for original image.
    /// - Parameter output: Output path for generated icons. Default value is nil.
    /// - Throws: `IconService.Error` errors.
    func generateWatchOSIcons(for imageURL: URL, output: String? = nil) throws {
        try generateIcons(for: imageURL, idioms: [.watch, .watchMarketing], output: output)
    }

    /// Generates icons for Android platform.
    ///
    /// - Parameter imageURL: The url for original image.
    /// - Parameter output: Output path for generated icons. Default value is nil.
    /// - Throws: `IconService.Error` errors.
    func generateAndroidIcons(for imageURL: URL, output: String? = nil) throws {
        let image = try self.image(for: imageURL)
        var folderName = Keys.androidIconFolder
        if let output = output {
            folderName = output + folderName
        }
        try generateIcons(from: image,
                          icons: iconFactory.makeAndroidIcons(),
                          folderName: folderName)
    }

    // MARK: - Private

    private func image(for imageURL: URL) throws -> CIImage {
        guard let image = CIImage(contentsOf: imageURL) else {
            throw Error.imageCreationFailed
        }
        guard let width = image.properties[Keys.width] as? Float,
            let height = image.properties[Keys.height] as? Float else {
                throw Error.sizeReadingFailed
        }
        guard width == Keys.defaultSize, height == Keys.defaultSize else {
            throw Error.wrongSizeDetected
        }
        return image
    }

    /// Generates icons for Apple platforms.
    ///
    /// - Parameter imageURL: The url for original image.
    /// - Parameter idioms: Idioms for icons.
    /// - Parameter output: Output path for generated icons. Default value is nil.
    /// - Throws: `IconService.Error` errors.
    func generateIcons(for imageURL: URL, idioms: [Icon.Idiom], output: String? = nil) throws {
        let image = try self.image(for: imageURL)
        let iconSet = iconFactory.makeSet(withName: Keys.iconName,
                                          idioms: idioms)
        var folderName = Keys.iconSetName
        if let output = output {
            folderName = output + folderName
        }
        try generateIcons(from: image, icons: iconSet.icons, folderName: folderName)
        try writeContents(of: iconSet, output: output)
    }

    /// Writes `Contents.json` file that contains names of icons.
    ///
    /// - Parameter set: The set with icons.
    /// - Parameter output: Output path for generated icons. Default value is nil.
    /// - Throws: `File.Error.writeFailed` if the file couldn’t be written to.
    private func writeContents(of set: IconSet, output: String? = nil) throws {
        encoder.outputFormatting = .prettyPrinted
        let iconSetData = try encoder.encode(set)
        var path = Keys.iconSetName + "/" + Keys.contentsName
        if let output = output {
            path = output + path
        }
        let contentsFile = try fileSystem.createFile(at: path)
        try contentsFile.write(data: iconSetData)
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
            let scale = icon.iconSize / Keys.defaultSize
            filter.setValue(scale, forKey: kCIInputScaleKey)
            guard let outputImage = filter.value(forKey: kCIOutputImageKey) as? CIImage else {
                throw Error.imageRenderingFailed
            }
            guard let outputData = context.representation(of: outputImage, colorSpace: colorSpace) else {
                try fileSystem.currentFolder.subfolder(named: folderName).delete()
                throw Error.imageRenderingFailed
            }
            let path = [folderName, icon.iconName].joined(separator: "/")
            let file = try fileSystem.createFile(at: path)
            try file.write(data: outputData)
        }
    }
}

extension IconService.Error: CustomStringConvertible {

    var description: String {
        switch self {
        case .imageCreationFailed: return "Can't create an image."
        case .sizeReadingFailed: return "Can't get image size."
        case .wrongSizeDetected: return "Image has wrong size."
        case .imageRenderingFailed: return "Can't render the image."
        }
    }
}

extension CIContext {

    func representation(of image: CIImage,
                        format: CIFormat = kCIFormatRGBA8,
                        colorSpace: CGColorSpace,
                        options: [AnyHashable: Any] = [:]) -> Data? {
        if #available(OSX 10.13, *) {
            return pngRepresentation(of: image, format: format, colorSpace: colorSpace)
        }
        else if #available(OSX 10.12, *) {
            return jpegRepresentation(of: image, colorSpace: colorSpace)
        }
        return nil
    }
}
