//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation
import SashaCore

var registry = CommandRegistry(usage: "<command> <options>",
                               overview: "👨‍💼 Reduce daily designer routine with sasha")

do {
    registry.register(ProjectCommand.self, IconsCommand.self)
    try registry.run()
}
catch {
    print("❌ An error occurred:\n\(error.localizedDescription)")
}
