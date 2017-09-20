//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

enum Commands: String {
    case project
    case icons
    
    var task: Executable {
        switch self {
        case .project:
            return ProjectTask()
        case .icons:
            return IconsTask()
        }
    }
    
    var description: String {
        let prefix = "+ \(rawValue) \t"
        switch self {
        case .project:
            return prefix + "Generates a project folders tree according to project.sasha file."
        case .icons:
            return prefix + "Generates an icon set for selected platform."
        }
    }
    
    static var all: [Commands] {
        return [.project, .icons]
    }
    
    static var usageDescription: String {
        return """
        Usage:
        
        $ sasha COMMAND
        
        Commands:
        \(Commands.all.reduce("") { $0 + "\n" + $1.description })
        """
    }
}
