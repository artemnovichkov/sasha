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
        static let complicationName = "Complication"
        static let iconSetName = "AppIcon.appiconset"
        static let complicationSetName = "Complication.complicationset"
        static let contentsName = "Contents.json"
        static let androidIconFolder = "Android"
        static var defaultSize: Float = 0
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

    /// Generates icons for watchOS platform.
    ///
    /// - Parameter imageURL: The url for original image.
    /// - Parameter output: Output path for generated icons. Default value is nil.
    /// - Throws: `IconService.Error` errors.
    func generateWatchOSComplicationIcons(for imageURL: URL, output: String? = nil) throws {
        let idioms: [Icon.Idiom] = [.complicationCircular,
                                    .complicationExtraLarge,
                                    .complicationGraphicBezel,
                                    .complicationGraphicCircular,
                                    .complicationGraphicCorner,
                                    .complicationGraphicLargeRectangular,
                                    .complicationModular,
                                    .complicationUtilitarian]
        var folderName = Keys.complicationSetName
        if let output = output {
            folderName = output + folderName
        }
        for idiom in idioms {
            let iconSet = iconFactory.makeSet(withName: Keys.complicationName,
                                              idioms: [idiom])
            Keys.defaultSize = max(Keys.defaultSize, maxSize(for: iconSet))
        }
        let image = try self.image(for: imageURL)
        for idiom in idioms {
            let iconSet = iconFactory.makeSet(withName: Keys.complicationName,
                                              idioms: [idiom])
            let setFolderName = folderName + "/" + idiom.rawValue.capitalized + ".imageset"
            try generateIcons(from: image, icons: iconSet.icons, folderName: setFolderName)
            try writeContents(of: iconSet, path: setFolderName + "/" + Keys.contentsName)
        }
        try writeContents(of: iconFactory.makeComplicationSet(), path: folderName + "/" + Keys.contentsName)
    }

    /// Generates icons for Android platform.
    ///
    /// - Parameter imageURL: The url for original image.
    /// - Parameter output: Output path for generated icons. Default value is nil.
    /// - Throws: `IconService.Error` errors.
    func generateAndroidIcons(for imageURL: URL, output: String? = nil) throws {
        var folderName = Keys.androidIconFolder
        if let output = output {
            folderName = output + folderName
        }
        let icons = iconFactory.makeAndroidIcons()
        Keys.defaultSize = maxSize(for: icons)
        let image = try self.image(for: imageURL)
        try generateIcons(from: image,
                          icons: icons,
                          folderName: folderName)
    }

    /// Generates icons for Android Wear platform.
    ///
    /// - Parameter imageURL: The url for original image.
    /// - Parameter output: Output path for generated icons. Default value is nil.
    /// - Throws: `IconService.Error` errors.
    func generateAndroidWearIcons(for imageURL: URL, output: String? = nil) throws {
        var folderName = Keys.androidIconFolder
        if let output = output {
            folderName = output + folderName
        }
        let icons = iconFactory.makeAndroidWearIcons()
        Keys.defaultSize = maxSize(for: icons)
        let image = try self.image(for: imageURL)
        try generateIcons(from: image,
                          icons: icons,
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
        guard width >= Keys.defaultSize, height >= Keys.defaultSize else {
            throw Error.wrongSizeDetected
        }
        return image
    }

    func maxSize(for iconSet: AppIconSet) -> Float {
        let max = iconSet.icons.map { $0.size * $0.scale }.max()
        return max ?? 0
    }

    func maxSize(for iconSet: [AndroidIcon]) -> Float {
        let max = iconSet.map { $0.size }.max()
        return max ?? 0
    }

    /// Generates icons for Apple platforms.
    ///
    /// - Parameter imageURL: The url for original image.
    /// - Parameter idioms: Idioms for icons.
    /// - Parameter output: Output path for generated icons. Default value is nil.
    /// - Throws: `IconService.Error` errors.
    private func generateIcons(for imageURL: URL, idioms: [Icon.Idiom], output: String? = nil) throws {
        let iconSet = iconFactory.makeSet(withName: Keys.iconName,
                                          idioms: idioms)
        Keys.defaultSize = maxSize(for: iconSet)
        let image = try self.image(for: imageURL)
        var folderName = Keys.iconSetName
        if let output = output {
            folderName = output + folderName
        }
        try generateIcons(from: image, icons: iconSet.icons, folderName: folderName)
        var path = Keys.iconSetName + "/" + Keys.contentsName
        if let output = output {
            path = output + path
        }
        try writeContents(of: iconSet, path: path)
    }

    /// Writes contents file that contains names of icons.
    ///
    /// - Parameter set: The set with icons.
    /// - Parameter path: Path for generated icons.
    /// - Throws: `File.Error.writeFailed` if the file couldn’t be written to.
    private func writeContents(of set: AppIconSet, path: String) throws {
        encoder.outputFormatting = .prettyPrinted
        let iconSetData = try encoder.encode(set)
        let contentsFile = try fileSystem.createFile(at: path)
        try contentsFile.write(data: iconSetData)
    }

    /// Writes contents file that contains names of icons.
    ///
    /// - Parameter set: The set with assets.
    /// - Parameter path: Path for generated icons.
    /// - Throws: `File.Error.writeFailed` if the file couldn’t be written to.
    private func writeContents(of set: ComplicationSet, path: String) throws {
        encoder.outputFormatting = .prettyPrinted
        let iconSetData = try encoder.encode(set)
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
