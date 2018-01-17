//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation
import SashaCore

var registry = CommandRegistry(usage: "<command> <options>",
                               overview: "👨‍💼 Reduce daily designer routine with sasha")
registry.register(ProjectCommand.self, IconsCommand.self)
registry.run()
