import Domain
import SwiftUI

// The small inline bits that describe a place: its rating, how long to spend, and price.

public struct RatingPill: View {
    private let rating: Double

    public init(rating: Double) {
        self.rating = rating
    }

    public var body: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: "star.fill")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(WanderlyColor.saffron)
            Text(rating, format: .number.precision(.fractionLength(1)))
                .font(WanderlyFont.footnote)
                .foregroundStyle(.white)
        }
        .padding(.horizontal, Spacing.sm)
        .frame(height: 26)
        .background(Capsule().fill(Color(hex: "#140E0A").opacity(0.52)))
    }
}

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

    public static func humanized(_ minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        if hours == 0 { return "\(mins) min" }
        if mins == 0 { return "\(hours) hr" }
        return "\(hours) hr \(mins) min"
    }
}

public struct PriceLevelLabel: View {
    private let level: PriceLevel

    public init(_ level: PriceLevel) {
        self.level = level
    }

    public var body: some View {
        Text(level.symbol)
            .font(.system(size: 13, weight: .bold))
            .tracking(0.5)
            .foregroundStyle(WanderlyColor.ink2)
    }
}
