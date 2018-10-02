//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation
import Utility
import Basic

public struct CommandRegistry {

    private let parser: ArgumentParser
    private var commands: [Command] = []

    public init(usage: String, overview: String) {
        parser = ArgumentParser(usage: usage, overview: overview)
    }

    public mutating func register(_ command: Command.Type) {
        commands.append(command.init(parser: parser))
    }

    public mutating func register(_ commands: Command.Type...) {
        commands.forEach { register($0) }
    }

    public func run() {
        do {
            let arguments = try parse()
            try process(arguments)
        }
        catch {
            print(error)
        }
    }

    private func parse() throws -> ArgumentParser.Result {
        let arguments = Array(CommandLine.arguments.dropFirst())
        return try parser.parse(arguments)
    }

    private func process(_ arguments: ArgumentParser.Result) throws {
        guard let subparser = arguments.subparser(parser),
            let command = commands.first(where: { $0.command == subparser }) else {
                parser.printUsage(on: stdoutStream)
                return
        }
        try command.run(with: arguments)
    }
}
