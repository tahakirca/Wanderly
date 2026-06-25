import SwiftUI

extension Color {
    /// Builds a color from a hex string like "#BE5A63" or "BE5A63".
    /// Supports an optional leading "#" and an 8-digit RGBA form.
    init(hex: String) {
        var value = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if value.hasPrefix("#") {
            value.removeFirst()
        }

        var rgba: UInt64 = 0
        Scanner(string: value).scanHexInt64(&rgba)

        let red, green, blue, alpha: Double
        switch value.count {
        case 8:
            red = Double((rgba & 0xFF00_0000) >> 24) / 255
            green = Double((rgba & 0x00FF_0000) >> 16) / 255
            blue = Double((rgba & 0x0000_FF00) >> 8) / 255
            alpha = Double(rgba & 0x0000_00FF) / 255
        default:
            red = Double((rgba & 0xFF0000) >> 16) / 255
            green = Double((rgba & 0x00FF00) >> 8) / 255
            blue = Double(rgba & 0x0000FF) / 255
            alpha = 1
        }

        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }
}

extension UIColor {
    convenience init(hex: String) {
        self.init(Color(hex: hex))
    }
}
