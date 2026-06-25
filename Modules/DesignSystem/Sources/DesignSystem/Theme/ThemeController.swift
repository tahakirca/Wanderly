import SwiftUI

/// Drives the app's color scheme. Bind `colorScheme` to `.preferredColorScheme`.
public final class ThemeController: ObservableObject {
    public enum Mode: String, CaseIterable, Sendable {
        case system
        case light
        case dark
    }

    @Published public var mode: Mode

    public init(mode: Mode = .system) {
        self.mode = mode
    }

    public var colorScheme: ColorScheme? {
        switch mode {
        case .system: nil
        case .light: .light
        case .dark: .dark
        }
    }

    public func toggle() {
        mode = (mode == .dark) ? .light : .dark
    }
}
