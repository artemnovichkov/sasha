//
//  Sasha.swift
//  Sasha
//
//  Created by Artem Novichkov on 24/08/2017.
//
//

import Foundation
import Files

public final class Sasha {
    
    private let arguments: [String]
    
    init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard arguments.count > 1 else {
            throw Error.missingFileName
        }
        let fileName = arguments[1]
        
        do {
            try FileSystem().createFile(at: fileName)
        }
        catch {
            throw Error.failedToCreateFile
        }
    }
}

public extension Sasha {
    enum Error: Swift.Error {
        case missingFileName
        case failedToCreateFile
    }
}
