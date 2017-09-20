//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

enum Platform: String {
    case iOS, android
    
    static var all: [Platform] {
        return [.iOS, .android]
    }
    
}
