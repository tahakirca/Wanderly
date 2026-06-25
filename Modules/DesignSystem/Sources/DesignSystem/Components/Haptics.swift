import UIKit

/// Thin wrapper over UIKit feedback generators.
@MainActor
public enum Haptics {
    public static func light() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }

    public static func medium() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }

    public static func selection() {
        UISelectionFeedbackGenerator().selectionChanged()
    }
}
