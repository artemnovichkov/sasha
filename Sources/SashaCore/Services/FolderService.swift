//
//  FolderService.swift
//  Files
//
//  Created by Artem Novichkov on 29/08/2017.
//

import Foundation

final class FolderService {
    
    enum Keys {
        static let slash = "/"
    }
    
    private class Folder {
        let name: String
        let level: Int
        var subfolders = [Folder]()
        
        init(name: String, level: Int) {
            self.name = name
            self.level = level
        }
        
        func add(_ folder: Folder) {
            if folder.level == level + 1 {
                subfolders.append(folder)
                return
            }
            subfolders.last?.add(folder)
        }
    }
    
    /// Generates the paths for project folders from configuration string.
    ///
    /// - Parameter string: The string from `sasha.project` file.
    /// - Returns: The array of full paths.
    func paths(fromString string: String) -> [String] {
        let components = string.components(separatedBy: "\n")
        let allFolders = components.map { component -> Folder in
            let name = component.replacingOccurrences(of: "-", with: "")
            let level = component.characters.filter { $0 == "-" }
            return Folder(name: name, level: level.count)
        }
        var paths = [String]()
        var currentLevel = 0
        var currentPath: String?
        allFolders.forEach { folder in
            if let path = currentPath {
                if folder.level > currentLevel {
                    currentPath = path + Keys.slash + folder.name
                }
                else {
                    var components = path.components(separatedBy: Keys.slash)
                    var subComponents = components[0..<folder.level]
                    subComponents.append(folder.name)
                    currentPath = subComponents.joined(separator: Keys.slash)
                }
                currentLevel = folder.level
            }
            else {
                currentPath = folder.name
                currentLevel = folder.level
            }
            if let path = currentPath {
                paths.append(path)
            }
        }
        return paths
    }
}
