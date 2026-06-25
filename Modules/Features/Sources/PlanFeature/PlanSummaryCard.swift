import DesignSystem
import Domain
import SwiftUI

struct PlanSummaryCard: View {
    let summary: TripSummary

    var body: some View {
        HStack {
            stat(value: "\(summary.stopCount)", label: "Stops")
            divider
            stat(value: DurationLabel.humanized(summary.totalDurationMinutes), label: "Duration")
            divider
            stat(value: ClockTime.string(fromMinutes: summary.endMinutes), label: "Wrap-up")
        }
        .padding(.vertical, Spacing.lg)
        .frame(maxWidth: .infinity)
        .background(WanderlyColor.bgElevated, in: RoundedRectangle(cornerRadius: Radius.card))
        .shadow(.card)
    }

    private func stat(value: String, label: String) -> some View {
        VStack(spacing: Spacing.xs) {
            Text(value)
                .font(WanderlyFont.headline)
                .foregroundStyle(WanderlyColor.ink)
            Text(label.uppercased())
                .font(WanderlyFont.caption)
                .foregroundStyle(WanderlyColor.ink3)
        }
        .frame(maxWidth: .infinity)
    }

    private var divider: some View {
        Rectangle()
            .fill(WanderlyColor.hairline)
            .frame(width: 1, height: 32)
    }
}
