import DesignSystem
import Domain
import SwiftUI

struct PlanSummaryCard: View {
    let summary: TripSummary

    var body: some View {
        HStack {
            StatTile(value: "\(summary.stopCount)", label: "Stops")
            divider
            StatTile(value: DurationLabel.humanized(summary.totalDurationMinutes), label: "Duration")
            divider
            StatTile(value: ClockTime.string(fromMinutes: summary.endMinutes), label: "Wrap-up")
        }
        .padding(.vertical, Spacing.lg)
        .frame(maxWidth: .infinity)
        .background(WanderlyColor.bgElevated, in: RoundedRectangle(cornerRadius: Radius.card))
        .shadow(.card)
    }

    private var divider: some View {
        Rectangle()
            .fill(WanderlyColor.hairline)
            .frame(width: 1, height: 32)
    }
}
