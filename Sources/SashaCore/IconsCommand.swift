//
//  Copyright © 2018 Rosberry. All rights reserved.
//

import Utility

public struct IconsCommand: Command {

    public let command = "icons"
    public let overview = "Generates an icon set for selected platform."
    private let platform: OptionArgument<Platform>
    private let fileName: OptionArgument<String>

    public init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        platform = subparser.add(option: "--platform",
                                 shortName: "-p",
                                 kind: Platform.self,
                                 usage: "Platform for icon")
        fileName = subparser.add(option: "--filename",
                                 shortName: "-f",
                                 kind: String.self,
                                 usage: "Filename of original image.")
    }

    public func run(with arguments: ArgumentParser.Result) throws {
        guard let platform = arguments.get(platform),
        let fileName = arguments.get(fileName) else {
            //TODO: add errors
            return
        }
        try IconsTask().generateIcons(for: platform, fileName: fileName)
    }
}
