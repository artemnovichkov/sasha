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
    func makeSet(withName name: String, idioms: [Icon.Idiom]) -> AppIconSet {
        let icons = idioms.flatMap { idiom in
            makeIcons(forName: name, idiom: idiom)
        }
        return AppIconSet(icons: icons)
    }

    func makeComplicationSet() -> ComplicationSet {
        let assets = [Asset(idiom: .watch, filename: "Circular.imageset", role: .circular),
                      Asset(idiom: .watch, filename: "Extra Large.imageset", role: .extraLarge),
                      Asset(idiom: .watch, filename: "Modular.imageset", role: .modular),
                      Asset(idiom: .watch, filename: "Utilitarian.imageset", role: .utilitarian)]
        return ComplicationSet(assets: assets)
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

    /// Makes an array of icons for Android Wear. The names of icons contain full paths including needed folders.
    ///
    /// - Returns: The array of icons.
    func makeAndroidWearIcons() -> [AndroidIcon] {
        return [AndroidIcon(size: 72, name: "mipmap-hdpi/ic_launcher.png"),
                AndroidIcon(size: 48, name: "mipmap-mdpi/ic_launcher.png"),
                AndroidIcon(size: 96, name: "mipmap-xhdpi/ic_launcher.png"),
                AndroidIcon(size: 144, name: "mipmap-xxhdpi/ic_launcher.png")]
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
            return [Icon(idiom: idiom, size: 20, filename: name, scale: 2),
                    Icon(idiom: idiom, size: 20, filename: name, scale: 3),
                    Icon(idiom: idiom, size: 29, filename: name, scale: 2),
                    Icon(idiom: idiom, size: 29, filename: name, scale: 3),
                    Icon(idiom: idiom, size: 40, filename: name, scale: 2),
                    Icon(idiom: idiom, size: 40, filename: name, scale: 3),
                    Icon(idiom: idiom, size: 60, filename: name, scale: 2),
                    Icon(idiom: idiom, size: 60, filename: name, scale: 3)]
        case .ipad:
            return [Icon(idiom: idiom, size: 20, filename: name, scale: 1),
                    Icon(idiom: idiom, size: 20, filename: name, scale: 2),
                    Icon(idiom: idiom, size: 29, filename: name, scale: 1),
                    Icon(idiom: idiom, size: 29, filename: name, scale: 2),
                    Icon(idiom: idiom, size: 40, filename: name, scale: 1),
                    Icon(idiom: idiom, size: 40, filename: name, scale: 2),
                    Icon(idiom: idiom, size: 76, filename: name, scale: 1),
                    Icon(idiom: idiom, size: 76, filename: name, scale: 2),
                    Icon(idiom: idiom, size: 83.5, filename: name, scale: 2)]
        case .iosMarketing:
            return [Icon(idiom: idiom, size: 1024, filename: name, scale: 1)]
        case .carplay:
            return [Icon(idiom: idiom, size: 60, filename: name, scale: 2),
                    Icon(idiom: idiom, size: 60, filename: name, scale: 3)]
        case .mac:
            return [Icon(idiom: idiom,  size: 16, filename: name, scale: 1),
                    Icon(idiom: idiom,size: 16, filename: name, scale: 2),
                    Icon(idiom: idiom,size: 32, filename: name, scale: 1),
                    Icon(idiom: idiom,size: 32, filename: name, scale: 2),
                    Icon(idiom: idiom,size: 128, filename: name, scale: 1),
                    Icon(idiom: idiom,size: 128, filename: name, scale: 2),
                    Icon(idiom: idiom,size: 256, filename: name, scale: 1),
                    Icon(idiom: idiom,size: 256, filename: name, scale: 2),
                    Icon(idiom: idiom,size: 512, filename: name, scale: 1),
                    Icon(idiom: idiom,size: 512, filename: name, scale: 2)]
        case .watch:
            return [Icon(idiom: idiom,size: 24, filename: name, scale: 2, role: .notificationCenter, subtype: .mm38),
                    Icon(idiom: idiom, size: 27.5, filename: name, scale: 2, role: .notificationCenter, subtype: .mm42),
                    Icon(idiom: idiom,size: 29, filename: name, scale: 2, role: .companionSettings),
                    Icon(idiom: idiom, size: 29, filename: name, scale: 3, role: .companionSettings),
                    Icon(idiom: idiom, size: 40, filename: name, scale: 2, role: .appLauncher, subtype: .mm38),
                    Icon(idiom: idiom, size: 44, filename: name, scale: 2, role: .appLauncher, subtype: .mm40),
                    Icon(idiom: idiom, size: 50, filename: name, scale: 2, role: .appLauncher, subtype: .mm44),
                    Icon(idiom: idiom, size: 86, filename: name, scale: 2, role: .quickLook, subtype: .mm38),
                    Icon(idiom: idiom, size: 98, filename: name, scale: 2, role: .quickLook, subtype: .mm42),
                    Icon(idiom: idiom, size: 108, filename: name, scale: 2, role: .quickLook, subtype: .mm44)]
        case .watchMarketing:
            return [Icon(idiom: idiom, size: 1024, filename: name, scale: 1)]
        case .complicationCircular:
            return [Icon(idiom: idiom, size: 16, filename: name, screenWidth: "<=145", scale: 2),
                    Icon(idiom: idiom, size: 18, filename: name, screenWidth: ">145", scale: 2)]
        case .complicationExtraLarge:
            return [Icon(idiom: idiom, size: 91, filename: name, screenWidth: "<=145", scale: 2),
                    Icon(idiom: idiom, size: 101.5, filename: name, screenWidth: ">145", scale: 2)]
        case .complicationModular:
            return [Icon(idiom: idiom, size: 26, filename: name, screenWidth: "<=145", scale: 2),
                    Icon(idiom: idiom, size: 29, filename: name, screenWidth: ">145", scale: 2)]
        case .complicationUtilitarian:
            return [Icon(idiom: idiom, size: 20, filename: name, screenWidth: "<=145", scale: 2),
                    Icon(idiom: idiom, size: 22, filename: name, screenWidth: ">145", scale: 2)]
        }
    }
}
