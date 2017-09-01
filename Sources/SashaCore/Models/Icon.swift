//
//  Icon.swift
//  Files
//
//  Created by Artem Novichkov on 01/09/2017.
//

import Foundation

final class Icon {
    
    enum Idiom {
        case iphone, ipad
    }
    
    let idiom: Idiom
    let size: Int
    let scale: Int
    let filename: String
    
    init(idiom: Idiom, size: Int, scale: Int, filename: String) {
        self.idiom = idiom
        self.size = size
        self.scale = scale
        self.filename = filename
    }
}
