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
            return [Icon(idiom: .iphone, size: 20, scale: 2, filename: name),
                    Icon(idiom: .iphone, size: 20, scale: 3, filename: name),
                    Icon(idiom: .iphone, size: 29, scale: 1, filename: name),
                    Icon(idiom: .iphone, size: 29, scale: 2, filename: name),
                    Icon(idiom: .iphone, size: 29, scale: 3, filename: name),
                    Icon(idiom: .iphone, size: 40, scale: 2, filename: name),
                    Icon(idiom: .iphone, size: 40, scale: 3, filename: name),
                    Icon(idiom: .iphone, size: 57, scale: 1, filename: name),
                    Icon(idiom: .iphone, size: 57, scale: 2, filename: name),
                    Icon(idiom: .iphone, size: 60, scale: 2, filename: name),
                    Icon(idiom: .iphone, size: 60, scale: 3, filename: name)]
        case .ipad:
            return [Icon(idiom: .ipad, size: 20, scale: 1, filename: name),
                    Icon(idiom: .ipad, size: 20, scale: 2, filename: name),
                    Icon(idiom: .ipad, size: 29, scale: 1, filename: name),
                    Icon(idiom: .ipad, size: 29, scale: 2, filename: name),
                    Icon(idiom: .ipad, size: 40, scale: 1, filename: name),
                    Icon(idiom: .ipad, size: 40, scale: 2, filename: name),
                    Icon(idiom: .ipad, size: 76, scale: 1, filename: name),
                    Icon(idiom: .ipad, size: 76, scale: 2, filename: name),
                    Icon(idiom: .ipad, size: 83.5, scale: 2, filename: name)]
        case .iosMarketing:
            return [Icon(idiom: .iosMarketing, size: 1024, scale: 1, filename: name)]
        case .car:
            return [Icon(idiom: .car, size: 60, scale: 2, filename: name),
                    Icon(idiom: .car, size: 60, scale: 3, filename: name)]
        case .mac:
            return [Icon(idiom: .mac, size: 16, scale: 1, filename: name),
                    Icon(idiom: .mac, size: 16, scale: 2, filename: name),
                    Icon(idiom: .mac, size: 32, scale: 1, filename: name),
                    Icon(idiom: .mac, size: 32, scale: 2, filename: name),
                    Icon(idiom: .mac, size: 128, scale: 1, filename: name),
                    Icon(idiom: .mac, size: 128, scale: 2, filename: name),
                    Icon(idiom: .mac, size: 256, scale: 1, filename: name),
                    Icon(idiom: .mac, size: 256, scale: 2, filename: name),
                    Icon(idiom: .mac, size: 512, scale: 1, filename: name),
                    Icon(idiom: .mac, size: 512, scale: 2, filename: name)]
        }
    }
}
