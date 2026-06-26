import SwiftUI

public struct StatTile: View {
    public enum Emphasis {
        case onSurface   // dark text on a light card
        case onColor     // white text on a coloured hero, with a glass background
    }

    private let value: String
    private let label: String
    private let emphasis: Emphasis

    public init(value: String, label: String, emphasis: Emphasis = .onSurface) {
        self.value = value
        self.label = label
        self.emphasis = emphasis
    }

    public var body: some View {
        VStack(spacing: Spacing.xs) {
            Text(value)
                .font(WanderlyFont.headline)
                .foregroundStyle(emphasis == .onColor ? Color.white : WanderlyColor.ink)
            Text(label.uppercased())
                .font(WanderlyFont.caption)
                .foregroundStyle(emphasis == .onColor ? Color.white.opacity(0.8) : WanderlyColor.ink3)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, emphasis == .onColor ? Spacing.md : 0)
        .background(glassBackground)
    }

    @ViewBuilder
    private var glassBackground: some View {
        if emphasis == .onColor {
            RoundedRectangle(cornerRadius: Radius.tile).fill(.white.opacity(0.15))
        }
    }
}
