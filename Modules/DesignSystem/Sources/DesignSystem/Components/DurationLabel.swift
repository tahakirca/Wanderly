import SwiftUI

/// Clock icon + humanized duration ("45 min", "3 hr", "1 hr 30 min").
public struct DurationLabel: View {
    private let minutes: Int

    public init(minutes: Int) {
        self.minutes = minutes
    }

    public var body: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: "clock")
                .font(.system(size: 12))
            Text(DurationLabel.humanized(minutes))
        }
        .font(WanderlyFont.footnote)
        .foregroundStyle(WanderlyColor.ink2)
    }

    /// "45 min", "3 hr", "1 hr 30 min".
    public static func humanized(_ minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        if hours == 0 { return "\(mins) min" }
        if mins == 0 { return "\(hours) hr" }
        return "\(hours) hr \(mins) min"
    }
}

#Preview {
    VStack(alignment: .leading, spacing: Spacing.sm) {
        DurationLabel(minutes: 45)
        DurationLabel(minutes: 180)
        DurationLabel(minutes: 90)
    }
    .padding()
}
