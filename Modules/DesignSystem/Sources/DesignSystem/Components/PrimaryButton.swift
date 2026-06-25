import SwiftUI

/// 54pt teal call-to-action with an optional leading icon.
public struct PrimaryButton: View {
    private let title: String
    private let icon: String?
    private let action: () -> Void

    public init(_ title: String, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }

    public var body: some View {
        Button {
            Haptics.medium()
            action()
        } label: {
            HStack(spacing: Spacing.sm) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 17, weight: .semibold))
                }
                Text(title)
                    .font(WanderlyFont.headline)
            }
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(WanderlyColor.teal, in: RoundedRectangle(cornerRadius: Radius.button))
            .shadow(.primaryButton)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: Spacing.lg) {
        PrimaryButton("Add to Plan") {}
        PrimaryButton("Share Plan", icon: "square.and.arrow.up") {}
    }
    .padding()
}
