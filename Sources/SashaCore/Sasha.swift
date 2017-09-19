//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

public final class Sasha {
    
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        if arguments.count <= 1 {
            print(Commands.usageDescription)
            return
        }
        if let command = Commands(rawValue: arguments[1]) {
            try command.task.run()
        }
    }
}
