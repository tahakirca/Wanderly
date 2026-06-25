import SwiftUI

/// Rose node on the My Plan timeline: filled circle with the stop's order number.
public struct TimelineNode: View {
    private let order: Int

    public init(order: Int) {
        self.order = order
    }

    public var body: some View {
        Text("\(order)")
            .font(.system(size: 13, weight: .bold))
            .foregroundStyle(.white)
            .frame(width: 30, height: 30)
            .background(Circle().fill(WanderlyColor.rose))
            .overlay(Circle().strokeBorder(WanderlyColor.bg, lineWidth: 4))
    }
}

/// Hollow rose node used on the read-only Trip Summary timeline.
public struct TimelineNodeHollow: View {
    public init() {}

    public var body: some View {
        Circle()
            .strokeBorder(WanderlyColor.rose, lineWidth: 3)
            .frame(width: 14, height: 14)
            .background(Circle().fill(WanderlyColor.bg))
    }
}

/// Thin vertical line that joins consecutive timeline nodes.
public struct TimelineConnector: View {
    public init() {}

    public var body: some View {
        Rectangle()
            .fill(WanderlyColor.hairline)
            .frame(width: 2)
    }
}

#Preview {
    HStack(spacing: Spacing.xl) {
        VStack(spacing: 0) {
            TimelineNode(order: 1)
            TimelineConnector().frame(height: 40)
            TimelineNode(order: 2)
        }
        TimelineNodeHollow()
    }
    .padding()
}
