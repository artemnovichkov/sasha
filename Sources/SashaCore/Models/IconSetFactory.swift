//
//  IconSetFactory.swift
//  Files
//
//  Created by Artem Novichkov on 01/09/2017.
//

import Foundation

final class IconSetFactory {
    
    func makeIconSet() -> IconSet {
        let images = [Icon(idiom: .iphone, size: 20, scale: 1),
                      Icon(idiom: .iphone, size: 20, scale: 2),
                      Icon(idiom: .iphone, size: 20, scale: 3),
                      Icon(idiom: .iphone, size: 29, scale: 1),
                      Icon(idiom: .iphone, size: 29, scale: 2),
                      Icon(idiom: .iphone, size: 29, scale: 3),
                      Icon(idiom: .iphone, size: 40, scale: 1),
                      Icon(idiom: .iphone, size: 40, scale: 2),
                      Icon(idiom: .iphone, size: 40, scale: 3),
                      Icon(idiom: .iphone, size: 57, scale: 1),
                      Icon(idiom: .iphone, size: 57, scale: 2),
                      Icon(idiom: .iphone, size: 60, scale: 2),
                      Icon(idiom: .iphone, size: 60, scale: 3),
                      Icon(idiom: .ipad, size: 20, scale: 1),
                      Icon(idiom: .ipad, size: 20, scale: 2),
                      Icon(idiom: .ipad, size: 29, scale: 1),
                      Icon(idiom: .ipad, size: 29, scale: 2),
                      Icon(idiom: .ipad, size: 40, scale: 1),
                      Icon(idiom: .ipad, size: 40, scale: 2),
                      Icon(idiom: .ipad, size: 76, scale: 1),
                      Icon(idiom: .ipad, size: 76, scale: 2),
                      Icon(idiom: .ipad, size: 83.5, scale: 2),
                      Icon(idiom: .iosMarketing, size: 1024, scale: 1)]
        return IconSet(images: images)
    }
}
