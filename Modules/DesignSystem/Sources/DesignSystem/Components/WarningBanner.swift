import SwiftUI

/// Amber banner shown when the planned day runs long (>10h).
public struct WarningBanner: View {
    private let message: String

    public init(message: String) {
        self.message = message
    }

    public var body: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 15))
                .foregroundStyle(WanderlyColor.warn)
            Text(message)
                .font(WanderlyFont.footnote)
                .foregroundStyle(WanderlyColor.warn)
            Spacer()
        }
        .padding(Spacing.md)
        .background(WanderlyColor.warnBg, in: RoundedRectangle(cornerRadius: Radius.tile))
    }
}

#Preview {
    WarningBanner(message: "That's a packed day — over 10 hours of plans.")
        .padding()
}
