import SwiftUI

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

#Preview {
    RatingPill(rating: 4.8)
        .padding()
        .background(WanderlyColor.ink)
}
