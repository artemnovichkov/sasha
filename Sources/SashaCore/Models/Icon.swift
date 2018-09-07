//
//  Copyright © 2017 Artem Novichkov. All rights reserved.
//

import Foundation
import Utility

final class Icon: Codable {

    /// Idioms of icons.
    enum Idiom: String, Codable, ArgumentKind {

        case iphone, ipad, iosMarketing = "ios-marketing", carplay = "car", mac, watch, watchMarketing = "watch-marketing"

        static var completion: ShellCompletion = .none

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
        case notificationCenter, companionSettings, appLauncher, longLook, quickLook
    }

    /// Subtypes of watchOS icons with `notificationCenter` role.
    enum Subtype: String, Codable {
        case mm38 = "38mm", mm42 = "42mm"
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
