//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation
import Files

final class ProjectTask {
    
    enum Error: Swift.Error {
        case sketchTemplatesCreationFailed
    }
    
    private enum Keys {
        static let fileTemplates = "~/.sasha/file_templates/"
    }
    
    private let folderService: FolderService
    private let fileSystem: FileSystem
    
    init(folderService: FolderService = FolderService(),
         fileSystem: FileSystem = FileSystem()) {
        self.folderService = folderService
        self.fileSystem = fileSystem
    }
    
    func createProject(withName name: String) throws {
        let projectFile = try File(path: "~/.sasha/project.sasha")
        let projectString = try projectFile.readAsString()
        
        let paths = folderService.paths(fromString: projectString)
        try paths.forEach { path in
            let finalPath = name + FolderService.Keys.slash + path
            try fileSystem.createFolder(at: finalPath)
        }
        
        let projectFolder = try Folder.current.subfolder(named: name)
        do {
            try addSketchFiles(to: projectFolder, projectName: name.lowercased())
        }
        catch  {
            throw Error.sketchTemplatesCreationFailed
        }
        
        print("🎉 Project \(name) was successfully created.")
    }
    
    private func addSketchFiles(to folder: Folder, projectName: String) throws {
        //TODO: Hardcoded paths. Think about it.
        try Platform.all.forEach { platform in
            let platformName = platform.rawValue
            let sketchFile = try File(path: Keys.fileTemplates + "\(platformName.lowercased())_template.sketch")
            let sketchFileData = try sketchFile.read()
            let fileName = "\(platformName)/UI/" + projectName + " -\(platformName.lowercased()).sketch"
            try folder.createFile(named: fileName, contents: sketchFileData)
        }
    }
}

extension ProjectTask.Error: LocalizedError {
    
    var localizedDescription: String {
        switch self {
        case .sketchTemplatesCreationFailed:
            return "Can't create Sketch project files from templates. Please check ~/.sasha/file_templates folder."
        }
    }
}
