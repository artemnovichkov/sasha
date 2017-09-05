//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation

enum Command: String {
    
    case help
    case project
    case icons
}

struct Option {
    
    let short: String
    let long: String
}

class CommandService {
    
    func command(forArguments arguments: [String]) -> Command {
        <#function body#>
    }
}
