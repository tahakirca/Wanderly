import SwiftUI
import Domain

/// Frosted pill with the category-colored icon and name. Sits over card images.
public struct CategoryBadge: View {
    private let category: PlaceCategory

    public init(_ category: PlaceCategory) {
        self.category = category
    }

    public var body: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: WanderlyColor.symbol(for: category))
                .font(.system(size: 11, weight: .semibold))
                .foregroundStyle(WanderlyColor.accent(for: category))
            Text(category.title)
                .font(WanderlyFont.caption)
                .foregroundStyle(WanderlyColor.ink)
        }
        .padding(.horizontal, Spacing.sm)
        .frame(height: 28)
        .background(.regularMaterial, in: Capsule())
    }
}

#Preview {
    HStack {
        CategoryBadge(.landmark)
        CategoryBadge(.cafe)
    }
    .padding()
    .background(WanderlyColor.ink)
}
