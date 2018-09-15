//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation
import Utility

final class Icon: Codable {

    enum CodingKeys: String, CodingKey {
        case idiom
        case size
        case filename
        case screenWidth = "screen-width"
        case scale
        case role
        case subtype
    }

    /// Idioms of icons.
    enum Idiom: String, Codable, ArgumentKind {

        case iphone
        case ipad
        case iosMarketing = "ios-marketing"
        case carplay = "car"
        case mac
        case watch
        case watchMarketing = "watch-marketing"
        case complicationCircular = "circular"
        case complicationExtraLarge = "extra large"
        case complicationModular = "modular"
        case complicationUtilitarian = "utilitarian"

        static let completion: ShellCompletion = .none

        init(argument: String) throws {
            guard let idiom = Idiom(rawValue: argument) else {
                throw Error.invalidIdiom
            }
            self = idiom
        }
    }

    enum Error: Swift.Error {
        case invalidIdiom
    }

    /// Roles of watchOS icons.
    enum Role: String, Codable {
        case notificationCenter
        case companionSettings
        case appLauncher
        case quickLook
        case circular
        case extraLarge = "extra-large"
        case modular
        case utilitarian
    }

    /// Subtypes of watchOS icons with `notificationCenter` role.
    enum Subtype: String, Codable {
        case mm38 = "38mm", mm40 = "40mm", mm42 = "42mm", mm44 = "44mm"
    }

    let idiom: Idiom
    let size: Float
    let filename: String
    let screenWidth: String?
    let scale: Float
    let role: Role?
    let subtype: Subtype?

    init(idiom: Idiom,
         size: Float,
         filename: String,
         screenWidth: String? = nil,
         scale: Float,
         role: Role? = nil,
         subtype: Subtype? = nil) {
        self.idiom = idiom
        self.size = size
        let sizeString = String(format: "%g", size)
        let scaleString = String(format: "%g", scale)
        self.filename = filename + "-\(sizeString)x\(sizeString)@\(scaleString)x.png"
        self.screenWidth = screenWidth
        self.scale = scale
        self.role = role
        self.subtype = subtype
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let complications: [Idiom] = [.complicationCircular,
                                      .complicationExtraLarge,
                                      .complicationModular,
                                      .complicationUtilitarian]
        let isComplication = complications.contains(idiom)
        if isComplication {
            try container.encode(Idiom.watch, forKey: .idiom)
        }
        else {
            try container.encode(idiom, forKey: .idiom)
        }
        let scaleString = String(format: "%g", scale)
        if !isComplication {
            let sizeString = String(format: "%g", size)
            try container.encode("\(sizeString)x\(sizeString)", forKey: .size)
        }
        try container.encode(filename, forKey: .filename)
        if isComplication {
            try container.encodeIfPresent(screenWidth, forKey: .screenWidth)
        }
        try container.encode("\(scaleString)x", forKey: .scale)
        try container.encodeIfPresent(role, forKey: .role)
        try container.encodeIfPresent(subtype, forKey: .subtype)
    }
}

extension Icon: IconRepresentable {

    var iconSize: Float {
        return size * scale
    }

    var iconName: String {
        return filename
    }
}

extension Icon.Error: CustomStringConvertible {

    var description: String {
        switch self {
        case .invalidIdiom:
            return "Invalid idiom."
        }
    }
}
