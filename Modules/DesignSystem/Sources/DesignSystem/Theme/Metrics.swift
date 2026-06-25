import SwiftUI

public enum Spacing {
    public static let xs: CGFloat = 4
    public static let sm: CGFloat = 8
    public static let md: CGFloat = 12
    public static let lg: CGFloat = 16
    public static let xl: CGFloat = 20
    public static let xxl: CGFloat = 24
    public static let xxxl: CGFloat = 32
    public static let screenEdge: CGFloat = 20
}

public enum Radius {
    public static let card: CGFloat = 20
    public static let button: CGFloat = 16
    public static let tile: CGFloat = 14
}

enum CardMetrics {
    static let imageHeight: CGFloat = 180
}

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

    public static let card = Shadow(color: Color.black.opacity(0.1), radius: 8, offsetY: 4)
    public static let primaryButton = Shadow(color: WanderlyColor.teal.opacity(0.25), radius: 12, offsetY: 6)
    public static let addButtonActive = Shadow(color: WanderlyColor.teal.opacity(0.25), radius: 12, offsetY: 4)
    public static let roseHero = Shadow(color: WanderlyColor.rose.opacity(0.3), radius: 16, offsetY: 10)
    public static let snackbar = Shadow(color: Color.black.opacity(0.3), radius: 16, offsetY: 12)
}

extension View {
    public func shadow(_ token: Shadow) -> some View {
        shadow(color: token.color, radius: token.radius, x: token.offsetX, y: token.offsetY)
    }
}
