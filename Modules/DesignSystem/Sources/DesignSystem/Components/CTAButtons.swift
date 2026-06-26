import SwiftUI

extension View {
    public func primaryCTAStyle() -> some View {
        font(WanderlyFont.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(WanderlyColor.teal, in: RoundedRectangle(cornerRadius: Radius.button))
            .shadow(.primaryButton)
    }

    public func secondaryCTAStyle() -> some View {
        font(WanderlyFont.headline)
            .foregroundStyle(WanderlyColor.rose)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(WanderlyColor.roseSoft, in: RoundedRectangle(cornerRadius: Radius.button))
            .overlay(
                RoundedRectangle(cornerRadius: Radius.button)
                    .strokeBorder(WanderlyColor.rose, lineWidth: 1)
            )
    }
}

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
            ctaLabel(title, icon: icon).primaryCTAStyle()
        }
        .buttonStyle(.plain)
    }
}

public struct SecondaryButton: View {
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
            ctaLabel(title, icon: icon).secondaryCTAStyle()
        }
        .buttonStyle(.plain)
    }
}

@ViewBuilder
private func ctaLabel(_ title: String, icon: String?) -> some View {
    HStack(spacing: Spacing.sm) {
        if let icon {
            Image(systemName: icon)
                .font(.system(size: 17, weight: .semibold))
        }
        Text(title)
    }
}

#Preview {
    VStack(spacing: Spacing.lg) {
        PrimaryButton("Add to Plan", icon: "plus") {}
        SecondaryButton("Remove from Plan", icon: "minus.circle.fill") {}
    }
    .padding()
}
