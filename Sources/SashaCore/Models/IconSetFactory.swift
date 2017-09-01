//
//  IconSetFactory.swift
//  Files
//
//  Created by Artem Novichkov on 01/09/2017.
//

import Foundation

final class IconSetFactory {
    
    func makeSet(withName name: String) -> IconSet {
        let images = [Icon(idiom: .iphone, size: 20, scale: 1, filename: name),
                      Icon(idiom: .iphone, size: 20, scale: 2, filename: name),
                      Icon(idiom: .iphone, size: 20, scale: 3, filename: name),
                      Icon(idiom: .iphone, size: 29, scale: 1, filename: name),
                      Icon(idiom: .iphone, size: 29, scale: 2, filename: name),
                      Icon(idiom: .iphone, size: 29, scale: 3, filename: name),
                      Icon(idiom: .iphone, size: 40, scale: 1, filename: name),
                      Icon(idiom: .iphone, size: 40, scale: 2, filename: name),
                      Icon(idiom: .iphone, size: 40, scale: 3, filename: name),
                      Icon(idiom: .iphone, size: 57, scale: 1, filename: name),
                      Icon(idiom: .iphone, size: 57, scale: 2, filename: name),
                      Icon(idiom: .iphone, size: 60, scale: 2, filename: name),
                      Icon(idiom: .iphone, size: 60, scale: 3, filename: name),
                      Icon(idiom: .ipad, size: 20, scale: 1, filename: name),
                      Icon(idiom: .ipad, size: 20, scale: 2, filename: name),
                      Icon(idiom: .ipad, size: 29, scale: 1, filename: name),
                      Icon(idiom: .ipad, size: 29, scale: 2, filename: name),
                      Icon(idiom: .ipad, size: 40, scale: 1, filename: name),
                      Icon(idiom: .ipad, size: 40, scale: 2, filename: name),
                      Icon(idiom: .ipad, size: 76, scale: 1, filename: name),
                      Icon(idiom: .ipad, size: 76, scale: 2, filename: name),
                      Icon(idiom: .ipad, size: 83.5, scale: 1, filename: name),
                      Icon(idiom: .iosMarketing, size: 1024, scale: 1, filename: name)]
        return IconSet(images:images)
    }
}
