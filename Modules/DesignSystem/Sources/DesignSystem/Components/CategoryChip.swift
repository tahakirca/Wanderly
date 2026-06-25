import SwiftUI
import Domain

/// Filter pill in the Explore category scroller. Selected fills rose; idle uses surface.
public struct CategoryChip: View {
    private let title: String
    private let symbol: String
    private let accent: Color
    private let isSelected: Bool
    private let action: () -> Void

    /// Generic chip (e.g. the "All" entry) with a custom symbol.
    public init(
        title: String,
        symbol: String,
        accent: Color = WanderlyColor.ink2,
        isSelected: Bool,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.symbol = symbol
        self.accent = accent
        self.isSelected = isSelected
        self.action = action
    }

    /// Convenience for a real place category.
    public init(category: PlaceCategory, isSelected: Bool, action: @escaping () -> Void) {
        self.init(
            title: category.title,
            symbol: WanderlyColor.symbol(for: category),
            accent: WanderlyColor.accent(for: category),
            isSelected: isSelected,
            action: action
        )
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: Spacing.xs) {
                Image(systemName: symbol)
                    .font(.system(size: 13, weight: .semibold))
                    .foregroundStyle(isSelected ? .white : accent)
                Text(title)
                    .font(WanderlyFont.footnote)
                    .foregroundStyle(isSelected ? .white : WanderlyColor.ink2)
            }
            .padding(.horizontal, Spacing.md)
            .frame(height: 37)
            .background(isSelected ? WanderlyColor.rose : WanderlyColor.surface, in: Capsule())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    HStack {
        CategoryChip(title: "All", symbol: "square.grid.2x2", isSelected: true) {}
        CategoryChip(category: .restaurant, isSelected: false) {}
    }
    .padding()
}
