//
//  Copyright © 2018 Rosberry. All rights reserved.
//

import Utility

public struct ProjectCommand: Command {

    public let command = "project"
    public let overview = "Generates a project folders tree according to project.sasha file."
    private let projectName: OptionArgument<String>

    public init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        projectName = subparser.add(option: "--name",
                                 shortName: "-n",
                                 kind: String.self,
                                 usage: "Name of the project.")
    }

    public func run(with arguments: ArgumentParser.Result) throws {
        guard let projectName = arguments.get(projectName) else {
                //TODO: add errors
                return
        }
        try ProjectTask().createProject(withName: projectName)
    }
}
