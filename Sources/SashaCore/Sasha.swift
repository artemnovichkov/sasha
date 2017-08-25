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
    
    public init(arguments: [String] = CommandLine.arguments) {
        self.arguments = arguments
    }
    
    public func run() throws {
        guard arguments.count > 1 else {
            throw Error.missingProjectName
        }
        let projectName = arguments[1]
        
        do {
            let projectFolder = try FileSystem().createFolder(at: projectName)
            let uiFolder = try projectFolder.createSubfolder(named: "UI")
            try addPlatformSubfolders(to: uiFolder)
            
            let uxFolder = try projectFolder.createSubfolder(named: "UX")
            try addPlatformSubfolders(to: uxFolder)
            
            let referencesFolder = try projectFolder.createSubfolder(named: "references")
            try referencesFolder.createSubfolder(named: "main-screens")
            try referencesFolder.createSubfolder(named: "menu")
            try referencesFolder.createSubfolder(named: "cards")
            try referencesFolder.createSubfolder(named: "another-case")
            
            let stuffFolder = try projectFolder.createSubfolder(named: "stuff")
            try stuffFolder.createSubfolder(named: "logos")
            try stuffFolder.createSubfolder(named: "icons")
            try stuffFolder.createSubfolder(named: "patterns")
            try stuffFolder.createSubfolder(named: "stocks")
            try stuffFolder.createSubfolder(named: "source")
        }
        catch {
            throw Error.failedToCreateFile
        }
    }
    
    private func addPlatformSubfolders(to folder: Folder) throws {
        let iosFolder = try folder.createSubfolder(named: "iOS")
        try iosFolder.createSubfolder(named: "old")
        try iosFolder.createSubfolder(named: "png")
        let androidFolder = try folder.createSubfolder(named: "Android")
        try androidFolder.createSubfolder(named: "old")
        try androidFolder.createSubfolder(named: "png")
    }
}

public extension Sasha {
    enum Error: Swift.Error {
        case missingProjectName
        case failedToCreateFile
    }
}
