//
//  UIColor+Extensions.swift
//  alohomora
//
//  Created by Janine Leal on 16/07/26.
//

import UIKit

extension UIColor {
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let a, r, g, b: UInt64

        switch hexSanitized.count {
        case 3:
            (a, r, g, b) = (255,
                            (rgb >> 8) * 17,
                            (rgb >> 4 & 0xF) * 17,
                            (rgb & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255,
                            rgb >> 16,
                            rgb >> 8 & 0xFF,
                            rgb & 0xFF)
        case 8:
            (a, r, g, b) = (rgb >> 24,
                            rgb >> 16 & 0xFF,
                            rgb >> 8 & 0xFF,
                            rgb & 0xFF)
        default:
            return nil
        }

        self.init(red: CGFloat(r) / 255,
                  green: CGFloat(g) / 255,
                  blue: CGFloat(b) / 255,
                  alpha: CGFloat(a) / 255)
    }

    var toHex: String? {
        guard let components = cgColor.components, components.count >= 3 else { return nil }
        
        let r = Int(components[0] * 255)
        let g = Int(components[1] * 255)
        let b = Int(components[2] * 255)
        
        return String(format: "#%02X%02X%02X", r, g, b)
    }
}
