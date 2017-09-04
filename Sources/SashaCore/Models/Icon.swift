//
//  Icon.swift
//  Files
//
//  Created by Artem Novichkov on 01/09/2017.
//

import Foundation

final class Icon: Codable {
    
    /// Idioms of icons.
    enum Idiom: String, Codable {
        case iphone, ipad, iosMarketing = "ios-marketing", car, mac, watch, watchMarketing = "watch-marketing"
    }
    
    /// Roles of watchOS icons.
    enum Role: String, Codable {
        case notificationCenter, companionSettings, appLauncher, longLook, quickLook
    }
    
    /// Subtypes of watchOS icons with `notificationCenter` role.
    enum Subtype: String, Codable {
        case mm38, mm42
    }
    
    let size: Float
    let idiom: Idiom
    let filename: String
    let scale: Float
    let role: Role?
    let subtype: Subtype?
    
    init(size: Float, idiom: Idiom, filename: String, scale: Float, role: Role? = nil, subtype: Subtype? = nil) {
        self.size = size
        self.idiom = idiom
        let sizeString = String(format: "%g", size)
        let scaleString = String(format: "%g", scale)
        self.filename = filename + "-\(sizeString)x\(sizeString)@\(scaleString)x.png"
        self.scale = scale
        self.role = role
        self.subtype = subtype
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let sizeString = String(format: "%g", size)
        let scaleString = String(format: "%g", scale)
        try container.encode("\(sizeString)x\(sizeString)", forKey: .size)
        try container.encode(idiom, forKey: .idiom)
        try container.encode(filename, forKey: .filename)
        try container.encode("\(scaleString)x", forKey: .scale)
        if let role = role {
            try container.encode(role, forKey: .role)
        }
        if let subtype = subtype {
            try container.encode(subtype, forKey: .subtype)
        }
    }
}

extension Icon: IconRepresentable {
    
    func iconSize() -> Float {
        return size * scale
    }
    
    func iconName() -> String {
        return filename
    }
}
