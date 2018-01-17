//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation
import Swiftline
import Files

final class IconsTask {
    
    private let iconService: IconService
    
    init(iconService: IconService = IconService()) {
        self.iconService = iconService
    }
    
    func generateIcons(for platform: Platform, fileName: String) throws {
        let file: File
        if fileName.contains("/") {
            file = try Folder.current.file(named: fileName)
        }
        else {
            file = try File(path: fileName)
        }
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
