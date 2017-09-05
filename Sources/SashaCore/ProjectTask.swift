//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation
import Files
import Swiftline

final class ProjectTask: Executable {
    
    private let folderService: FolderService
    private let fileSystem: FileSystem
    
    init(folderService: FolderService = FolderService(),
         fileSystem: FileSystem = FileSystem()) {
        self.folderService = folderService
        self.fileSystem = fileSystem
    }
    
    func run() throws {
        let projectName = ask("Enter project name:") { settings in
            settings.addInvalidCase("Project name should be non-empty", invalidIfTrue: { string in return string.count > 0 })
        }
        do {
            let projectFile = try File(path: "/usr/local/bin/project.sasha")
            let projectString = try projectFile.readAsString()
            
            let paths = folderService.paths(fromString: projectString)
            try paths.forEach { path in
                let finalPath = projectName + FolderService.Keys.slash + path
                try fileSystem.createFolder(at: finalPath)
            }
            print("✅ Project \(projectName) was successfully added.")
        }
        catch {
            throw Error.main
        }
    }
}

extension ProjectTask {
    
    enum Error: Swift.Error {
        case main
        case missingProjectName
    }
}

extension ProjectTask.Error: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .main: return "Project creation error. Please check that project.sasha file exists and has correct structure"
        case .missingProjectName: return "Can't find project name. Please add it as parameter, for example: sasha ProjectName"
        }
    }
}
