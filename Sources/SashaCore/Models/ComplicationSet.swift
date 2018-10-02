//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation

final class ComplicationSet: Codable {

    let assets: [Asset]
    let info: Info

    init(assets: [Asset], info: Info = .default) {
        self.assets = assets
        self.info = info
    }
}
