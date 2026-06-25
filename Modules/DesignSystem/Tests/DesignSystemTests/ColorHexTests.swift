import SwiftUI
import Testing
@testable import DesignSystem

@Suite("Color hex parsing")
struct ColorHexTests {
    @Test("Parses a 6-digit hex with a leading hash")
    func sixDigitWithHash() {
        let bytes = channels(of: Color(hex: "#BE5A63"))

        #expect(approx(bytes[0], 0xBE))
        #expect(approx(bytes[1], 0x5A))
        #expect(approx(bytes[2], 0x63))
        #expect(approx(bytes[3], 255))
    }

    @Test("Parses an 8-digit hex with an alpha channel")
    func eightDigitWithAlpha() {
        let bytes = channels(of: Color(hex: "0E8C8480"))

        #expect(approx(bytes[0], 0x0E))
        #expect(approx(bytes[1], 0x8C))
        #expect(approx(bytes[2], 0x84))
        #expect(approx(bytes[3], 0x80))
    }

    /// Returns red, green, blue, alpha as 0...255 byte values.
    private func channels(of color: Color) -> [Double] {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        UIColor(color).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return [red, green, blue, alpha].map { Double($0) * 255 }
    }

    private func approx(_ value: Double, _ target: Int) -> Bool {
        abs(value - Double(target)) < 1
    }
}
