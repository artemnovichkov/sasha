//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation

struct Info: Codable {

    let version: Int
    let author: String

    static let `default` = Info(version: 1, author: "sasha")
}
