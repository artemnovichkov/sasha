//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation

final class Asset: Codable {

    let idiom: Icon.Idiom
    let filename: String
    let role: Icon.Role?

    init(idiom: Icon.Idiom,
         filename: String,
         role: Icon.Role? = nil) {
        self.idiom = idiom
        self.filename = filename
        self.role = role
    }
}
