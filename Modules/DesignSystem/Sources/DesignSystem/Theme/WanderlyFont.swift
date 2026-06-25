import SwiftUI

/// Typography scale from the handoff. System SF Pro with the given sizes and weights.
public enum WanderlyFont {
    public static let largeTitle = Font.system(size: 34, weight: .bold)
    public static let sheetTitle = Font.system(size: 24, weight: .bold)
    public static let headline = Font.system(size: 17, weight: .semibold)
    public static let body = Font.system(size: 16, weight: .regular)
    public static let callout = Font.system(size: 16, weight: .semibold)
    public static let subhead = Font.system(size: 14, weight: .regular)
    public static let footnote = Font.system(size: 13, weight: .medium)
    public static let caption = Font.system(size: 12, weight: .semibold)
}

extension View {
    func captionStyle() -> some View {
        font(WanderlyFont.caption)
            .textCase(.uppercase)
            .tracking(0.5)
    }
}
