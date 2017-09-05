//
//  Sasha.swift
//  Sasha
//
//  Created by Artem Novichkov on 24/08/2017.
//
//

public final class Sasha {
    
    private let arguments: [String]
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        if let command = Command(rawValue: arguments[1]) {
            try command.task.run()
        }
        else {
            print("wrong command")
        }
    }
}
