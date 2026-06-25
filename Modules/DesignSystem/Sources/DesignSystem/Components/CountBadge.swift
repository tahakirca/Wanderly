import SwiftUI

public struct CountBadge: View {
    private let count: Int

    public init(count: Int) {
        self.count = count
    }

    public var body: some View {
        Text("\(count)")
            .font(.system(size: 11, weight: .bold))
            .foregroundStyle(.white)
            .frame(minWidth: 18, minHeight: 18)
            .padding(.horizontal, count > 9 ? 4 : 0)
            .background(Capsule().fill(WanderlyColor.saffron))
            .overlay(Capsule().strokeBorder(WanderlyColor.bgElevated, lineWidth: 2))
    }
}

#Preview {
    HStack(spacing: Spacing.lg) {
        CountBadge(count: 3)
        CountBadge(count: 12)
    }
    .padding()
}
