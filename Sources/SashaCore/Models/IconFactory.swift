//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation

final class IconFactory {
    
    /// Makes a set of icons. The set contains an icons only for selected idioms.
    ///
    /// - Parameters:
    ///   - name: The name of generated icons.
    ///   - idioms: The idioms of icons.
    /// - Returns: The set of icons.
    func makeSet(withName name: String, idioms: [Icon.Idiom]) -> IconSet {
        var icons = [Icon]()
        idioms.forEach { idiom in
            icons.append(contentsOf: makeIcons(forName: name, idiom: idiom))
        }
        return IconSet(icons: icons)
    }
    
    /// Makes a set of icons. The set contains an icons only for selected idiom.
    ///
    /// - Parameters:
    ///   - name: The name of generated icons.
    ///   - idiom: The idiom of icons.
    /// - Returns: The array of generated icons.
    private func makeIcons(forName name: String, idiom: Icon.Idiom) -> [Icon] {
        switch idiom {
        case .iphone:
            return [Icon(size: 20, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 20, idiom: idiom, filename: name, scale: 3),
                    Icon(size: 29, idiom: idiom, filename: name, scale: 1),
                    Icon(size: 29, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 29, idiom: idiom, filename: name, scale: 3),
                    Icon(size: 40, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 40, idiom: idiom, filename: name, scale: 3),
                    Icon(size: 57, idiom: idiom, filename: name, scale: 1),
                    Icon(size: 57, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 60, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 60, idiom: idiom, filename: name, scale: 3)]
        case .ipad:
            return [Icon(size: 20, idiom: idiom, filename: name, scale: 1),
                    Icon(size: 20, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 29, idiom: idiom, filename: name, scale: 1),
                    Icon(size: 29, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 40, idiom: idiom, filename: name, scale: 1),
                    Icon(size: 40, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 76, idiom: idiom, filename: name, scale: 1),
                    Icon(size: 76, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 83.5, idiom: idiom, filename: name, scale: 2)]
        case .iosMarketing:
            return [Icon(size: 1024, idiom: idiom, filename: name, scale: 1)]
        case .car:
            return [Icon(size: 60, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 60, idiom: idiom, filename: name, scale: 3)]
        case .mac:
            return [Icon(size: 16, idiom: idiom, filename: name, scale: 1),
                    Icon(size: 16, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 32, idiom: idiom, filename: name, scale: 1),
                    Icon(size: 32, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 128, idiom: idiom, filename: name, scale: 1),
                    Icon(size: 128, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 256, idiom: idiom, filename: name, scale: 1),
                    Icon(size: 256, idiom: idiom, filename: name, scale: 2),
                    Icon(size: 512, idiom: idiom, filename: name, scale: 1),
                    Icon(size: 512, idiom: idiom, filename: name, scale: 2)]
        case .watch:
            return [Icon(size: 24, idiom: idiom, filename: name, scale: 2, role: .notificationCenter, subtype: .mm38),
                    Icon(size: 27.5, idiom: idiom, filename: name, scale: 2, role: .notificationCenter, subtype: .mm42),
                    Icon(size: 29, idiom: idiom, filename: name, scale: 2, role: .companionSettings),
                    Icon(size: 29, idiom: idiom, filename: name, scale: 3, role: .companionSettings),
                    Icon(size: 40, idiom: idiom, filename: name, scale: 2, role: .appLauncher, subtype: .mm38),
                    Icon(size: 86, idiom: idiom, filename: name, scale: 2, role: .quickLook, subtype: .mm38),
                    Icon(size: 98, idiom: idiom, filename: name, scale: 2, role: .quickLook, subtype: .mm42)]
        case .watchMarketing:
            return [Icon(size: 1024, idiom: idiom, filename: name, scale: 1)]
        }
    }
    
    /// Makes an array of icons for Android. The names of icons contain full paths including needed folders.
    ///
    /// - Returns: The array of icons.
    func makeAndroidIcons() -> [AndroidIcon] {
        return [AndroidIcon(size: 72, name: "mipmap-hdpi/ic_launcher.png"),
                AndroidIcon(size: 36, name: "mipmap-ldpi/ic_launcher.png"),
                AndroidIcon(size: 48, name: "mipmap-mdpi/ic_launcher.png"),
                AndroidIcon(size: 96, name: "mipmap-xhdpi/ic_launcher.png"),
                AndroidIcon(size: 144, name: "mipmap-xxhdpi/ic_launcher.png"),
                AndroidIcon(size: 192, name: "mipmap-xxxhdpi/ic_launcher.png"),
                AndroidIcon(size: 512, name: "playstore-icon.png")]
    }
}
