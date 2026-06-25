import SwiftUI

public struct HoursCallout: View {
    private let hours: String

    public init(hours: String) {
        self.hours = hours
    }

    public var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "clock.fill")
                .font(.system(size: 15))
                .foregroundStyle(WanderlyColor.teal)
            Text(hours)
                .font(WanderlyFont.footnote)
                .foregroundStyle(WanderlyColor.ink)
            Spacer()
        }
        .padding(.horizontal, Spacing.md)
        .padding(.vertical, Spacing.md)
        .background(WanderlyColor.tealSoft, in: RoundedRectangle(cornerRadius: Radius.tile))
    }
}
