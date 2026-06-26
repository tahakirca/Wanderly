import SwiftUI

/// Circular light/dark toggle for the Explore header.
public struct ThemeToggleButton: View {
    private let theme: ThemeController

    public init(theme: ThemeController) {
        self.theme = theme
    }

    public var body: some View {
        Button {
            Haptics.selection()
            withAnimation(.easeInOut(duration: 0.25)) {
                theme.toggle()
            }
        } label: {
            Image(systemName: theme.colorScheme == .dark ? "sun.max.fill" : "moon.fill")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(WanderlyColor.ink2)
                .frame(width: 40, height: 40)
                .background(Circle().fill(WanderlyColor.surface))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    ThemeToggleButton(theme: ThemeController())
        .padding()
}
