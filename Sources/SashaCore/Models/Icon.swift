//
//  Icon.swift
//  Files
//
//  Created by Artem Novichkov on 01/09/2017.
//

import Foundation

final class Icon: Codable {
    
    enum Idiom: String, Codable {
        case iphone, ipad, iosMarketing = "ios-marketing"
    }
    
    let idiom: Idiom
    let size: Float
    let scale: Float
    let filename: String
    
    init(idiom: Idiom, size: Float, scale: Float, filename: String) {
        self.idiom = idiom
        self.size = size
        self.scale = scale
        let sizeString = String(format: "%g", size)
        let scaleString = String(format: "%g", scale)
        self.filename = filename + "-\(sizeString)x\(sizeString)@\(scaleString)x.png"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let sizeString = String(format: "%g", size)
        let scaleString = String(format: "%g", scale)
        try container.encode("\(sizeString)x\(sizeString)", forKey: .size)
        try container.encode(idiom, forKey: .idiom)
        try container.encode(filename, forKey: .filename)
        try container.encode("\(scaleString)x", forKey: .scale)
    }
}
