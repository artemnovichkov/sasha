//
//  Copyright © 2017 Rosberry. All rights reserved.
//

enum Command: String {
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
}
