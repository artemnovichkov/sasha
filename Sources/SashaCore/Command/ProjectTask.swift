//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation
import Swiftline
import Files

final class ProjectTask: Executable {
    
    private let folderService: FolderService
    private let fileSystem: FileSystem
    
    init(folderService: FolderService = FolderService(),
         fileSystem: FileSystem = FileSystem()) {
        self.folderService = folderService
        self.fileSystem = fileSystem
    }
    
    func run() throws {
        let projectName = ask("Enter project name: ") { settings in
            settings.addInvalidCase("Project name should be non-empty", invalidIfTrue: { $0.count == 0 })
        }
        let projectFile = try File(path: "~/.sasha/project.sasha")
        let projectString = try projectFile.readAsString()
        
        let paths = folderService.paths(fromString: projectString)
        try paths.forEach { path in
            let finalPath = projectName + FolderService.Keys.slash + path
            try fileSystem.createFolder(at: finalPath)
        }
        print("🎉 Project \(projectName) was successfully created.")
    }
}
