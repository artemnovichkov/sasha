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
    private let folderService = FolderService()
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard arguments.count > 1 else {
            throw Error.missingProjectName
        }
        let projectName = arguments[1]
        
        do {
            let projectFile = try FileSystem().currentFolder.file(named: "project.sasha")
            let projectString = try projectFile.readAsString()
            
            let paths = folderService.paths(fromString: projectString)
            try paths.forEach { path in
                let finalPath = projectName + FolderService.Keys.slash + path
                try FileSystem().createFolder(at: finalPath)
            }
        }
        catch {
            throw Error.failedToCreateFolder
        }
    }
}

public extension Sasha {
    enum Error: Swift.Error {
        case missingProjectName
        case failedToCreateFolder
    }
}
