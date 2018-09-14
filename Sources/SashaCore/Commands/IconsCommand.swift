//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
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
    private let output: OptionArgument<String>
    private let platform: OptionArgument<Platform>
    private let idioms: OptionArgument<[Icon.Idiom]>

    public init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        name = subparser.add(option: "--name",
                                 shortName: "-n",
                                 kind: String.self,
                                 usage: "Filename of original image. You can use full path of name of image file in current folder.")
        output = subparser.add(option: "--output",
                             shortName: "-o",
                             kind: String.self,
                             usage: "Output path for generated icons.")
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
        let output = arguments.get(self.output)
        try IconsTask().generateIcons(for: platform, idioms: idioms, path: fileName, output: output)
    }
}

extension IconsCommand.Error: CustomStringConvertible {

    var description: String {
        switch self {
        case .missingOptions:
            return "Missing --platform or --name options."
        }
    }
}
