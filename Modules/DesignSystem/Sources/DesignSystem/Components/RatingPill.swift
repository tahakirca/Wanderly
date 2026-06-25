import SwiftUI

/// Saffron star + one-decimal rating. Frosted dark style for use over images.
public struct RatingPill: View {
    private let rating: Double
    private let overImage: Bool

    public init(rating: Double, overImage: Bool = true) {
        self.rating = rating
        self.overImage = overImage
    }

    public var body: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: "star.fill")
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(WanderlyColor.saffron)
            Text(rating, format: .number.precision(.fractionLength(1)))
                .font(WanderlyFont.footnote)
                .foregroundStyle(overImage ? .white : WanderlyColor.ink)
        }
        .padding(.horizontal, Spacing.sm)
        .frame(height: 26)
        .background(background)
    }

    @ViewBuilder
    private var background: some View {
        if overImage {
            Capsule().fill(Color(hex: "#140E0A").opacity(0.52))
        } else {
            Capsule().fill(WanderlyColor.saffronSoft)
        }
    }
}

#Preview {
    HStack {
        RatingPill(rating: 4.8)
        RatingPill(rating: 4.3, overImage: false)
    }
    .padding()
    .background(WanderlyColor.ink)
}
