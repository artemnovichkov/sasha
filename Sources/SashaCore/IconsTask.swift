//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Swiftline

final class IconsTask: Executable {
    
    func run() throws {
        let type = choose("Select a platform: ", type: Int.self) { settings in
            settings.addChoice("iOS") { return 1 }
            settings.addChoice("Android") { return 2 }
        }
        print("\(type)")
    }
}
