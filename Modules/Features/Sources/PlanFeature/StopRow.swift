import DesignSystem
import Domain
import SwiftUI

struct StopRow: View {
    let stop: ScheduledStop

    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.xs) {
            if stop.travelMinutesBefore > 0 {
                travelGap
            }
            card
        }
    }

    private var travelGap: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: "car.fill")
            Text("\(stop.travelMinutesBefore) min travel")
        }
        .font(WanderlyFont.caption)
        .foregroundStyle(WanderlyColor.ink3)
        .padding(.leading, Spacing.lg)
    }

    private var card: some View {
        HStack(spacing: Spacing.md) {
            TimelineNode(order: stop.order)

            VStack(alignment: .leading, spacing: Spacing.xs) {
                Text(stop.place.category.title.uppercased())
                    .font(WanderlyFont.caption)
                    .foregroundStyle(WanderlyColor.accent(for: stop.place.category))
                Text(stop.place.name)
                    .font(WanderlyFont.callout)
                    .foregroundStyle(WanderlyColor.ink)
                HStack(spacing: Spacing.xs) {
                    Text(ClockTime.string(fromMinutes: stop.arrivalMinutes))
                        .foregroundStyle(WanderlyColor.teal)
                    Text("· \(DurationLabel.humanized(stop.place.estimatedDurationMinutes)) visit")
                        .foregroundStyle(WanderlyColor.ink2)
                }
                .font(WanderlyFont.footnote)
            }
            Spacer()
        }
        .padding(Spacing.md)
        .background(WanderlyColor.bgElevated, in: RoundedRectangle(cornerRadius: Radius.card))
        .shadow(.card)
    }
}
