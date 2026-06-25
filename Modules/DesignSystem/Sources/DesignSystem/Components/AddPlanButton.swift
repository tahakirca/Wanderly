import SwiftUI

/// 44pt circular add/remove toggle. Idle = white with teal plus; added = teal with white check.
public struct AddPlanButton: View {
    private let isAdded: Bool
    private let action: () -> Void

    public init(isAdded: Bool, action: @escaping () -> Void) {
        self.isAdded = isAdded
        self.action = action
    }

    public var body: some View {
        Button {
            Haptics.light()
            action()
        } label: {
            Image(systemName: isAdded ? "checkmark" : "plus")
                .font(.system(size: 18, weight: .bold))
                .foregroundStyle(isAdded ? .white : WanderlyColor.teal)
                .frame(width: 44, height: 44)
                .background(Circle().fill(isAdded ? WanderlyColor.teal : WanderlyColor.bgElevated))
                .overlay(Circle().strokeBorder(WanderlyColor.bgElevated, lineWidth: 3))
                .shadow(isAdded ? .addButtonActive : .card)
                .animation(.spring(response: 0.3, dampingFraction: 0.55), value: isAdded)
        }
        .buttonStyle(PopButtonStyle())
    }
}

/// Press feedback that gives the button a quick squeeze-and-pop.
private struct PopButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.88 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.55), value: configuration.isPressed)
    }
}

#Preview {
    HStack(spacing: Spacing.xl) {
        AddPlanButton(isAdded: false) {}
        AddPlanButton(isAdded: true) {}
    }
    .padding()
    .background(WanderlyColor.surface)
}
