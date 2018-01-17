//
//  Copyright © 2018 Rosberry. All rights reserved.
//

import Utility

public struct IconsCommand: Command {

    public let command = "icons"
    public let overview = "Generates an icon set for selected platform."

    public init(parser: ArgumentParser) {
        parser.add(subparser: command, overview: overview)
    }

    public func run(with arguments: ArgumentParser.Result) throws {
        try IconsTask().run()
    }
}
