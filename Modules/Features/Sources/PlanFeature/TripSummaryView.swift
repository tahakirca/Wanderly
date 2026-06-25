import DesignSystem
import Domain
import SwiftUI

struct TripSummaryView: View {
    let summary: TripSummary

    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.lg) {
                hero
                breakdown
                timeline
                shareButton
            }
            .padding(.horizontal, Spacing.screenEdge)
            .padding(.vertical, Spacing.lg)
        }
        .background(WanderlyColor.bg)
        .navigationTitle("Trip Summary")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar(.hidden, for: .tabBar)
    }

    private var hero: some View {
        VStack(spacing: Spacing.lg) {
            Text("\(ClockTime.string(fromMinutes: summary.startMinutes)) → \(ClockTime.string(fromMinutes: summary.endMinutes))")
                .font(WanderlyFont.sheetTitle)
                .foregroundStyle(.white)

            HStack(spacing: Spacing.sm) {
                heroTile(value: "\(summary.stopCount)", label: "Stops")
                heroTile(value: DurationLabel.humanized(summary.totalDurationMinutes), label: "Total time")
                heroTile(value: "$\(summary.totalCostUSD)", label: "Per person")
            }
        }
        .padding(Spacing.xl)
        .frame(maxWidth: .infinity)
        .background(WanderlyColor.rose, in: RoundedRectangle(cornerRadius: Radius.card))
        .shadow(.roseHero)
    }

    private func heroTile(value: String, label: String) -> some View {
        VStack(spacing: Spacing.xs) {
            Text(value)
                .font(WanderlyFont.headline)
                .foregroundStyle(.white)
            Text(label.uppercased())
                .font(WanderlyFont.caption)
                .foregroundStyle(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Spacing.md)
        .background(.white.opacity(0.15), in: RoundedRectangle(cornerRadius: Radius.tile))
    }

    private var breakdown: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.sm) {
                ForEach(summary.categoryBreakdown, id: \.category) { entry in
                    Text("\(entry.count) \(entry.category.title)")
                        .font(WanderlyFont.footnote)
                        .foregroundStyle(WanderlyColor.ink2)
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, Spacing.sm)
                        .background(WanderlyColor.surface, in: Capsule())
                }
            }
        }
    }

    private var timeline: some View {
        VStack(alignment: .leading, spacing: Spacing.lg) {
            ForEach(summary.stops) { stop in
                HStack(alignment: .top, spacing: Spacing.md) {
                    Text(ClockTime.string(fromMinutes: stop.arrivalMinutes))
                        .font(WanderlyFont.footnote)
                        .foregroundStyle(WanderlyColor.teal)
                        .frame(width: 64, alignment: .leading)
                    TimelineNodeHollow()
                        .padding(.top, Spacing.xs)
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text(stop.place.name)
                            .font(WanderlyFont.callout)
                            .foregroundStyle(WanderlyColor.ink)
                        Text("\(stop.place.category.title) · \(DurationLabel.humanized(stop.place.estimatedDurationMinutes))")
                            .font(WanderlyFont.footnote)
                            .foregroundStyle(WanderlyColor.ink2)
                    }
                    Spacer()
                }
            }
        }
        .padding(Spacing.lg)
        .frame(maxWidth: .infinity)
        .background(WanderlyColor.bgElevated, in: RoundedRectangle(cornerRadius: Radius.card))
        .shadow(.card)
    }

    private var shareButton: some View {
        PrimaryButton("Share Plan", icon: "square.and.arrow.up") {}
    }
}
