//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation
import Files

final class IconsTask {

    private let iconService: IconService

    init(iconService: IconService = IconService()) {
        self.iconService = iconService
    }

    func generateIcons(for platform: Platform,
                       idioms: [Icon.Idiom]? = nil,
                       path: String,
                       output: String? = nil) throws {
        let file: File
        if path.contains("/") {
            file = try File(path: path)
        }
        else {
            file = try Folder.current.file(named: path)
        }
        let url = URL(fileURLWithPath: file.path)
        switch platform {
        case .iOS:
            try iconService.generateIcons(for: url, idioms: idioms, output: output)
            print("🎉 AppIcon.appiconset was successfully created")
        case .android:
            try iconService.generateAndroidIcons(for: url)
            print("🎉 Icons were successfully created")
        }
    }
}
