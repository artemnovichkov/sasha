//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation
import Swiftline

final class IconsTask: Executable {
    
    enum Platform: String {
        case iOS, Android
    }
    
    private let iconService: IconService
    
    init(iconService: IconService = IconService()) {
        self.iconService = iconService
    }
    
    func run() throws {
        let platform = choose("Select a platform: ", type: Platform.self) { settings in
            [Platform.iOS, Platform.Android].forEach { platform in
                settings.addChoice(platform.rawValue) { return platform }
            }
        }
        let url = URL(fileURLWithPath: "/Users/artemnovichkov/Library/Developer/Xcode/DerivedData/Sasha-hasywgxoyhtmrwcgkrbczvzshcbj/Build/Products/Debug/logo.png")
        switch platform {
        case .iOS:
            try iconService.generateIcons(for: url)
        case .Android:
            try iconService.generateAndroidIcons(for: url)
        }
    }
}
