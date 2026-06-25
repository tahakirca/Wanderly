import SwiftUI
import Domain

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

#Preview {
    HStack(spacing: Spacing.lg) {
        PriceLevelLabel(.free)
        PriceLevelLabel(.low)
        PriceLevelLabel(.medium)
        PriceLevelLabel(.high)
    }
    .padding()
}
