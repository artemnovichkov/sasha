//
//  IconSetFactory.swift
//  Files
//
//  Created by Artem Novichkov on 01/09/2017.
//

import Foundation

final class IconSetFactory {
    
    func makeSet(withName name: String, idioms: [Icon.Idiom]) -> IconSet {
        var images = [Icon]()
        idioms.forEach { idiom in
            images.append(contentsOf: makeIcons(forName: name, idiom: idiom))
        }
        return IconSet(images: images)
    }
    
    private func makeIcons(forName name: String, idiom: Icon.Idiom) -> [Icon] {
        switch idiom {
        case .iphone:
            return [Icon(size: 20, idiom: .iphone, filename: name, scale: 2),
                    Icon(size: 20, idiom: .iphone, filename: name, scale: 3),
                    Icon(size: 29, idiom: .iphone, filename: name, scale: 1),
                    Icon(size: 29, idiom: .iphone, filename: name, scale: 2),
                    Icon(size: 29, idiom: .iphone, filename: name, scale: 3),
                    Icon(size: 40, idiom: .iphone, filename: name, scale: 2),
                    Icon(size: 40, idiom: .iphone, filename: name, scale: 3),
                    Icon(size: 57, idiom: .iphone, filename: name, scale: 1),
                    Icon(size: 57, idiom: .iphone, filename: name, scale: 2),
                    Icon(size: 60, idiom: .iphone, filename: name, scale: 2),
                    Icon(size: 60, idiom: .iphone, filename: name, scale: 3)]
        case .ipad:
            return [Icon(size: 20, idiom: .ipad, filename: name, scale: 1),
                    Icon(size: 20, idiom: .ipad, filename: name, scale: 2),
                    Icon(size: 29, idiom: .ipad, filename: name, scale: 1),
                    Icon(size: 29, idiom: .ipad, filename: name, scale: 2),
                    Icon(size: 40, idiom: .ipad, filename: name, scale: 1),
                    Icon(size: 40, idiom: .ipad, filename: name, scale: 2),
                    Icon(size: 76, idiom: .ipad, filename: name, scale: 1),
                    Icon(size: 76, idiom: .ipad, filename: name, scale: 2),
                    Icon(size: 83.5, idiom: .ipad, filename: name, scale: 2)]
        case .iosMarketing:
            return [Icon(size: 1024, idiom: .iosMarketing, filename: name, scale: 1)]
        case .car:
            return [Icon(size: 60, idiom: .car, filename: name, scale: 2),
                    Icon(size: 60, idiom: .car, filename: name, scale: 3)]
        case .mac:
            return [Icon(size: 16, idiom: .mac, filename: name, scale: 1),
                    Icon(size: 16, idiom: .mac, filename: name, scale: 2),
                    Icon(size: 32, idiom: .mac, filename: name, scale: 1),
                    Icon(size: 32, idiom: .mac, filename: name, scale: 2),
                    Icon(size: 128, idiom: .mac, filename: name, scale: 1),
                    Icon(size: 128, idiom: .mac, filename: name, scale: 2),
                    Icon(size: 256, idiom: .mac, filename: name, scale: 1),
                    Icon(size: 256, idiom: .mac, filename: name, scale: 2),
                    Icon(size: 512, idiom: .mac, filename: name, scale: 1),
                    Icon(size: 512, idiom: .mac, filename: name, scale: 2)]
        case .watch:
            return [Icon(size: 24, idiom: .watch, filename: name, scale: 2, role: .notificationCenter, subtype: .mm38),
                    Icon(size: 27.5, idiom: .watch, filename: name, scale: 2, role: .notificationCenter, subtype: .mm42),
                    Icon(size: 29, idiom: .watch, filename: name, scale: 2, role: .companionSettings),
                    Icon(size: 29, idiom: .watch, filename: name, scale: 3, role: .companionSettings),
                    Icon(size: 40, idiom: .watch, filename: name, scale: 2, role: .appLauncher),
                    Icon(size: 44, idiom: .watch, filename: name, scale: 2, role: .longLook),
                    Icon(size: 86, idiom: .watch, filename: name, scale: 2, role: .quickLook),
                    Icon(size: 98, idiom: .watch, filename: name, scale: 2, role: .quickLook)]
        case .watchMarketing:
            return [Icon(size: 1024, idiom: .watchMarketing, filename: name, scale: 1)]
        }
    }
}
