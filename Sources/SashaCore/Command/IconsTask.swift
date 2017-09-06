//
//  Copyright © 2017 Rosberry. All rights reserved.
//

import Foundation
import Swiftline
import Files

final class IconsTask: Executable {
    
    enum Platform: String {
        case iOS, android
    }
    
    private let iconService: IconService
    
    init(iconService: IconService = IconService()) {
        self.iconService = iconService
    }
    
    func run() throws {
        let platform = choose("Select a platform: ", type: Platform.self) { settings in
            [Platform.iOS, Platform.android].forEach { platform in
                settings.addChoice(platform.rawValue) { return platform }
            }
        }
        let fileName = ask("Enter file name: ")
        try generateIcons(for: platform, fileName: fileName)
    }
    
    private func generateIcons(for platform: Platform, fileName: String) throws {
        let file = try Folder.current.file(named: fileName)
        let url = URL(fileURLWithPath: file.path)
        switch platform {
        case .iOS:
            try iconService.generateIcons(for: url)
            print("🎉 AppIcon.appiconset was successfully created")
        case .android:
            try iconService.generateAndroidIcons(for: url)
            print("🎉 Icons were successfully created")
        }
    }
}
