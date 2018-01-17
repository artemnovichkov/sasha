//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation

final class IconSet: Codable {
    
    struct Info: Codable {
        
        let version: Int
        let author: String
        
        static var `default` = Info(version: 1, author: "sasha")
        
        init(version: Int, author: String) {
            self.version = version
            self.author = author
        }
    }
    
    let icons: [Icon]
    let info: Info
    
    init(icons: [Icon], info: Info = .default) {
        self.icons = icons
        self.info = info
    }
}
