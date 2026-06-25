import SwiftUI

/// A shimmering placeholder bar. Reusable for any skeleton layout.
public struct ShimmerBar: View {
    private let cornerRadius: CGFloat
    @State private var animating = false

    public init(cornerRadius: CGFloat = 6) {
        self.cornerRadius = cornerRadius
    }

    public var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(WanderlyColor.surface)
            .overlay {
                GeometryReader { geo in
                    LinearGradient(
                        colors: [.clear, WanderlyColor.surface2, .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geo.size.width * 0.6)
                    .offset(x: animating ? geo.size.width : -geo.size.width * 0.6)
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            .onAppear {
                withAnimation(.easeInOut(duration: 1.4).repeatForever(autoreverses: false)) {
                    animating = true
                }
            }
    }
}

/// Card-shaped skeleton shown while Explore loads.
public struct SkeletonCard: View {
    public init() {}

    public var body: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            ShimmerBar(cornerRadius: 0)
                .frame(height: CardMetrics.imageHeight)
            VStack(alignment: .leading, spacing: Spacing.sm) {
                ShimmerBar().frame(width: 180, height: 16)
                ShimmerBar().frame(height: 12)
                ShimmerBar().frame(width: 140, height: 12)
            }
            .padding(.horizontal, Spacing.lg)
            .padding(.bottom, Spacing.lg)
        }
        .background(WanderlyColor.bgElevated)
        .clipShape(RoundedRectangle(cornerRadius: Radius.card))
        .shadow(.card)
    }
}

#Preview {
    SkeletonCard()
        .padding()
        .background(WanderlyColor.bg)
}
