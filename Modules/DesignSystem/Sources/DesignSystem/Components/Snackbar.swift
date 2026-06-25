import SwiftUI

/// Dark pill toast with a message and an Undo button. Caller handles timing/dismiss.
public struct Snackbar: View {
    private let message: String
    private let onUndo: () -> Void

    public init(message: String, onUndo: @escaping () -> Void) {
        self.message = message
        self.onUndo = onUndo
    }

    public var body: some View {
        HStack(spacing: Spacing.md) {
            Image(systemName: "arrow.uturn.backward")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(WanderlyColor.saffron)
            Text(message)
                .font(WanderlyFont.footnote)
                .foregroundStyle(.white)
            Spacer(minLength: Spacing.sm)
            Button("Undo", action: onUndo)
                .font(WanderlyFont.callout)
                .foregroundStyle(WanderlyColor.teal)
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.vertical, Spacing.md)
        .background(Color(hex: "#2A2420"), in: Capsule())
        .shadow(.snackbar)
    }
}

#Preview {
    Snackbar(message: "Removed from plan") {}
        .padding()
}
