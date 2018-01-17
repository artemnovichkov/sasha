//
//  Copyright © 2018 Rosberry. All rights reserved.
//

import Foundation
import Utility

public struct IconsCommand: Command {

    enum Error: Swift.Error {
        case missingOptions
    }

    public let command = "icons"
    public let overview = "Generates an icon set for selected platform."
    private let name: OptionArgument<String>
    private let platform: OptionArgument<Platform>
    private let idioms: OptionArgument<[Icon.Idiom]>

    public init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        name = subparser.add(option: "--name",
                                 shortName: "-n",
                                 kind: String.self,
                                 usage: "Filename of original image. You can use full path of name of image file in current folder.")
        platform = subparser.add(option: "--platform",
                                 shortName: "-p",
                                 kind: Platform.self,
                                 usage: "Platform for icon.")
        idioms = subparser.add(option: "--idioms",
                               shortName: "-i",
                               kind: [Icon.Idiom].self,
                               usage: "A set of additional idioms.")
    }

    public func run(with arguments: ArgumentParser.Result) throws {
        guard let platform = arguments.get(platform),
            let fileName = arguments.get(name) else {
                throw Error.missingOptions
        }
        let idioms = arguments.get(self.idioms)
        try IconsTask().generateIcons(for: platform, idioms: idioms, fileName: fileName)
    }
}

extension IconsCommand.Error: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .missingOptions:
            return "Missing --platform or --name options."
        }
    }
}
