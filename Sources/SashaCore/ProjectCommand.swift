//
//  Copyright © 2018 Rosberry. All rights reserved.
//

import Utility

public struct ProjectCommand: Command {

    public let command = "project"
    public let overview = "Generates a project folders tree according to project.sasha file."

    public init(parser: ArgumentParser) {
        parser.add(subparser: command, overview: overview)
    }

    public func run(with arguments: ArgumentParser.Result) throws {
        try ProjectTask().run()
    }
}
