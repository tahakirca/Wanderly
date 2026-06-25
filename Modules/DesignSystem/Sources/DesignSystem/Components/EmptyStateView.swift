import SwiftUI

/// Centered illustration + copy + CTA. Used for the empty plan and "no results" states.
public struct EmptyStateView: View {
    private let icon: String
    private let title: String
    private let message: String
    private let actionTitle: String?
    private let action: (() -> Void)?

    public init(
        icon: String,
        title: String,
        message: String,
        actionTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        self.icon = icon
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
        self.action = action
    }

    public var body: some View {
        VStack(spacing: Spacing.lg) {
            Image(systemName: icon)
                .font(.system(size: 56))
                .foregroundStyle(WanderlyColor.rose)
                .frame(width: 120, height: 120)
                .background(Circle().fill(WanderlyColor.roseSoft))

            VStack(spacing: Spacing.sm) {
                Text(title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundStyle(WanderlyColor.ink)
                Text(message)
                    .font(WanderlyFont.subhead)
                    .foregroundStyle(WanderlyColor.ink2)
                    .multilineTextAlignment(.center)
            }

            if let actionTitle, let action {
                PrimaryButton(actionTitle, action: action)
                    .padding(.top, Spacing.sm)
            }
        }
        .padding(.horizontal, Spacing.xl)
        .frame(maxWidth: 360)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    EmptyStateView(
        icon: "map",
        title: "Your day is a blank canvas",
        message: "Browse Jaipur and add stops to build your itinerary.",
        actionTitle: "Browse places"
    ) {}
}
