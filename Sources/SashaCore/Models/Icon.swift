//
//  Icon.swift
//  Files
//
//  Created by Artem Novichkov on 01/09/2017.
//

import Foundation

final class Icon {
    
    enum Idiom {
        case iphone, ipad, iosMarketing
    }
    
    let idiom: Idiom
    let size: Float
    let scale: Int
    let filename: String
    
    init(idiom: Idiom, size: Float, scale: Int, filename: String) {
        self.idiom = idiom
        self.size = size
        self.scale = scale
        let sizeString = String(format: "%.0f", size)
        self.filename = filename + "-\(sizeString)x\(sizeString)@\(scale)x.png"
    }
}
