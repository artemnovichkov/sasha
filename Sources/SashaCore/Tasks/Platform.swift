//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation
import Utility

enum Platform: String, ArgumentKind {

    enum Error: Swift.Error {
        case invalid
    }

    static var completion: ShellCompletion = .values(Platform.all.map { ($0.rawValue, $0.rawValue) })

    init(argument: String) throws {
        guard let platform = Platform(rawValue: argument.lowercased()) else {
            throw Error.invalid
        }
        self = platform
    }

    case iOS = "ios"
    case watchOS = "watchos"
    case android

    static var all: [Platform] = [.iOS, .watchOS, .android]
}

extension Platform.Error: CustomStringConvertible {
    
    var description: String {
        switch self {
        case .invalid:
            return "Unsupported platform."
        }
    }
}
