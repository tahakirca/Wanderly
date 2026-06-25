import SwiftUI
import Domain

/// All Wanderly color tokens as dynamic light/dark colors so the UI follows the color scheme.
public enum WanderlyColor {
    public static let bg = dynamic(light: "#FBF7F2", dark: "#16120F")
    public static let bgElevated = dynamic(light: "#FFFFFF", dark: "#211C18")
    public static let surface = dynamic(light: "#F2EAE0", dark: "#2A2420")
    public static let surface2 = dynamic(light: "#E9DECF", dark: "#342D27")

    public static let ink = dynamic(light: "#2A2420", dark: "#F4EDE4")
    public static let ink2 = dynamic(light: "#6E635A", dark: "#B6ABA0")
    public static let ink3 = dynamic(light: "#AAA095", dark: "#80776C")
    public static let hairline = dynamic(light: "#ECE3D7", dark: "#322B25")

    public static let rose = dynamic(light: "#BE5A63", dark: "#E08A91")
    public static let roseSoft = dynamic(light: "#F7E6E6", dark: "#3A2623")
    public static let teal = dynamic(light: "#0E8C84", dark: "#3FB9AE")
    public static let tealSoft = dynamic(light: "#DBEEEB", dark: "#163330")
    public static let saffron = dynamic(light: "#E0912E", dark: "#E8A94E")
    public static let saffronSoft = dynamic(light: "#FAEACF", dark: "#3A2C16")
    public static let warn = dynamic(light: "#B96A16", dark: "#E8A94E")
    public static let warnBg = dynamic(light: "#FBEBD4", dark: "#382713")

    public static let scrim = dynamic(
        light: UIColor(red: 30 / 255, green: 22 / 255, blue: 16 / 255, alpha: 0.42),
        dark: UIColor(white: 0, alpha: 0.58)
    )

    public static func accent(for category: PlaceCategory) -> Color {
        switch category {
        case .landmark: dynamic(light: "#BE5A63", dark: "#E08A91")
        case .restaurant: dynamic(light: "#C9772B", dark: "#E0A05A")
        case .cafe: dynamic(light: "#8C6A46", dark: "#C2A079")
        case .activity: dynamic(light: "#0E8C84", dark: "#3FB9AE")
        case .shopping: dynamic(light: "#A85A86", dark: "#CE8FB4")
        }
    }

    public static func symbol(for category: PlaceCategory) -> String {
        switch category {
        case .landmark: "building.columns"
        case .restaurant: "fork.knife"
        case .cafe: "cup.and.saucer.fill"
        case .activity: "sparkles"
        case .shopping: "bag.fill"
        }
    }

    private static func dynamic(light: String, dark: String) -> Color {
        dynamic(light: UIColor(hex: light), dark: UIColor(hex: dark))
    }

    private static func dynamic(light: UIColor, dark: UIColor) -> Color {
        Color(uiColor: UIColor { traits in
            traits.userInterfaceStyle == .dark ? dark : light
        })
    }
}
