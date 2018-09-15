//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation
import Utility

enum Platform: String, ArgumentKind, CaseIterable {

    enum Error: Swift.Error {
        case invalid
    }

    static let completion: ShellCompletion = .values(Platform.allCases.map { ($0.rawValue, $0.rawValue) })

    init(argument: String) throws {
        guard let platform = Platform(rawValue: argument.lowercased()) else {
            throw Error.invalid
        }
        self = platform
    }

    case iOS = "ios"
    case macOS = "macos"
    case watchOS = "watchos"
    case watchOSComplication = "complication"
    case android
    case androidWear = "androidwear"
}

extension Platform.Error: CustomStringConvertible {

    var description: String {
        switch self {
        case .invalid:
            return "Unsupported platform."
        }
    }
}
