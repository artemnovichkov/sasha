//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Utility

enum Platform: String, ArgumentKind {

    enum Error: Swift.Error {
        case invalid
    }
    
    static var completion: ShellCompletion = .values(Platform.all.map { ($0.rawValue, $0.rawValue) })

    init(argument: String) throws {
        guard let platform = Platform(rawValue: argument) else {
            throw Error.invalid
        }
        self = platform
    }

    case iOS, android
    
    static var all: [Platform] = [.iOS, .android]
    
}
