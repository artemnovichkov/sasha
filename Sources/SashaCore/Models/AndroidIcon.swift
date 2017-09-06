//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation

final class AndroidIcon {
    
    let size: Float
    let name: String
    
    init(size: Float, name: String) {
        self.size = size
        self.name = name
    }
}

extension AndroidIcon: IconRepresentable {
    
    func iconSize() -> Float {
        return size
    }
    
    func iconName() -> String {
        return name
    }
}
