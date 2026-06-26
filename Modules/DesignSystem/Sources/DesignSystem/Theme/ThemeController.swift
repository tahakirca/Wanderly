import SwiftUI

/// Drives the app's color scheme. Bind `colorScheme` to `.preferredColorScheme`.
@Observable
@MainActor
public final class ThemeController {
    public enum Mode: String, CaseIterable, Sendable {
        case system
        case light
        case dark
    }

    public var mode: Mode

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
