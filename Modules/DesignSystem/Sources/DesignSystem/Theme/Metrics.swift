import SwiftUI

/// 8pt-based spacing scale.
public enum Spacing {
    public static let xs: CGFloat = 4
    public static let sm: CGFloat = 8
    public static let md: CGFloat = 12
    public static let lg: CGFloat = 16
    public static let xl: CGFloat = 20
    public static let xxl: CGFloat = 24
    public static let xxxl: CGFloat = 32

    /// Standard side padding for screen content.
    public static let screenEdge: CGFloat = 20
}

/// Corner radii.
public enum Radius {
    public static let card: CGFloat = 20
    public static let sheet: CGFloat = 26
    public static let button: CGFloat = 16
    public static let tile: CGFloat = 14
    public static let node: CGFloat = 15
}

/// Shadow tokens. Apply with `.shadow(token)`.
public struct Shadow: Sendable {
    public let color: Color
    public let radius: CGFloat
    public let offsetX: CGFloat
    public let offsetY: CGFloat

    public init(color: Color, radius: CGFloat, offsetX: CGFloat = 0, offsetY: CGFloat) {
        self.color = color
        self.radius = radius
        self.offsetX = offsetX
        self.offsetY = offsetY
    }

    public static let card = Shadow(color: Color.black.opacity(0.07), radius: 8, offsetY: 6)
    public static let lifted = Shadow(color: Color.black.opacity(0.30), radius: 20, offsetY: 18)
    public static let sheet = Shadow(color: Color.black.opacity(0.24), radius: 22, offsetY: -12)
    public static let primaryButton = Shadow(color: WanderlyColor.teal.opacity(0.30), radius: 9, offsetY: 6)
    public static let addButtonActive = Shadow(color: WanderlyColor.teal.opacity(0.42), radius: 7, offsetY: 5)
    public static let roseHero = Shadow(color: WanderlyColor.rose.opacity(0.34), radius: 14, offsetY: 12)
    public static let snackbar = Shadow(color: Color.black.opacity(0.32), radius: 17, offsetY: 14)
}

extension View {
    func shadow(_ token: Shadow) -> some View {
        shadow(color: token.color, radius: token.radius, x: token.offsetX, y: token.offsetY)
    }
}
