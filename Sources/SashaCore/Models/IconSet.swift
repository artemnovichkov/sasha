//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation

final class IconSet: Codable {
    
    final class Info: Codable {
        
        let version: Int
        let author: String
        
        static var `default`: Info {
            return Info(version: 1, author: "sasha")
        }
        
        init(version: Int, author: String) {
            self.version = version
            self.author = author
        }
    }
    
    let images: [Icon]
    let info: Info
    
    init(images: [Icon], info: Info = .default) {
        self.images = images
        self.info = info
    }
}
