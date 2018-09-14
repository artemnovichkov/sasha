//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation

final class AppIconSet: Codable {

    enum CodingKeys: String, CodingKey {
        case icons = "images"
        case info
    }

    let icons: [Icon]
    let info: Info

    init(icons: [Icon], info: Info = .default) {
        self.icons = icons
        self.info = info
    }
}
