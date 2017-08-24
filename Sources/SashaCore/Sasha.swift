//
//  Sasha.swift
//  Sasha
//
//  Created by Artem Novichkov on 24/08/2017.
//
//

import Foundation

public final class Sasha {
    
    private let arguments: [String]
    
    init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        print("Hello world")
    }
}
