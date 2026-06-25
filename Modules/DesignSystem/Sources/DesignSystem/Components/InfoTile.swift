import SwiftUI

/// Surface tile with a teal icon, a value and a caption label. Used in the detail sheet.
public struct InfoTile: View {
    private let icon: String
    private let value: String
    private let label: String

    public init(icon: String, value: String, label: String) {
        self.icon = icon
        self.value = value
        self.label = label
    }

    public var body: some View {
        VStack(spacing: Spacing.xs) {
            Image(systemName: icon)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(WanderlyColor.teal)
            Text(value)
                .font(WanderlyFont.callout)
                .foregroundStyle(WanderlyColor.ink)
            Text(label)
                .captionStyle()
                .foregroundStyle(WanderlyColor.ink3)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.md)
        .background(WanderlyColor.surface, in: RoundedRectangle(cornerRadius: Radius.tile))
    }
}

#Preview {
    HStack(spacing: Spacing.md) {
        InfoTile(icon: "clock", value: "1 hr 30 min", label: "Duration")
        InfoTile(icon: "location", value: "2.4 km", label: "Distance")
        InfoTile(icon: "creditcard", value: "$", label: "Price")
    }
    .padding()
}
