import DesignSystem
import Domain
import SwiftUI

struct StopRow: View {
    let stop: ScheduledStop
    let isFirst: Bool
    let isLast: Bool

    private let gapHeight: CGFloat = 28

    var body: some View {
        HStack(alignment: .top, spacing: Spacing.md) {
            rail
            content
        }
    }

    private var rail: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(WanderlyColor.hairline)
                .frame(width: 2, height: isFirst ? 0 : gapHeight)
            TimelineNode(order: stop.order)
            Rectangle()
                .fill(isLast ? Color.clear : WanderlyColor.hairline)
                .frame(width: 2)
                .frame(maxHeight: .infinity)
        }
        .frame(width: 30)
    }

    private var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !isFirst {
                travelGap
                    .frame(height: gapHeight)
            }
            card
                .padding(.bottom, Spacing.md)
        }
    }

    private var travelGap: some View {
        HStack(spacing: Spacing.xs) {
            Image(systemName: "car.fill")
            Text("\(stop.travelMinutesBefore) min travel")
        }
        .font(WanderlyFont.caption)
        .foregroundStyle(WanderlyColor.ink3)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var card: some View {
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
        .padding(Spacing.md)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WanderlyColor.bgElevated, in: RoundedRectangle(cornerRadius: Radius.card))
        .shadow(.card)
    }
}
