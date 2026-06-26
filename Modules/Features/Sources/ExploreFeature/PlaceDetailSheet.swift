import DesignSystem
import Domain
import SwiftUI

struct PlaceDetailSheet: View {
    let place: Place
    let isAdded: Bool
    let onToggle: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var added: Bool

    init(place: Place, isAdded: Bool, onToggle: @escaping () -> Void) {
        self.place = place
        self.isAdded = isAdded
        self.onToggle = onToggle
        _added = State(initialValue: isAdded)
    }

    var body: some View {
        VStack(spacing: 0) {
            grabber
            ScrollView {
                VStack(alignment: .leading, spacing: Spacing.lg) {
                    hero
                    title
                    infoTiles
                    HoursCallout(hours: place.openingHours)
                    Text(place.description)
                        .font(WanderlyFont.body)
                        .foregroundStyle(WanderlyColor.ink2)
                        .lineSpacing(4)
                    tags
                }
                .padding(.horizontal, Spacing.screenEdge)
                .padding(.bottom, Spacing.xl)
            }
            footer
        }
        .background(WanderlyColor.bgElevated)
        .onAppear { Haptics.medium() }
    }

    private var grabber: some View {
        Capsule()
            .fill(WanderlyColor.ink3.opacity(0.4))
            .frame(width: 38, height: 5)
            .padding(.top, Spacing.sm)
            .padding(.bottom, Spacing.md)
    }

    private var hero: some View {
        PlaceImage(url: place.imageURL)
            .frame(height: 236)
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: Radius.card))
            .overlay(alignment: .topTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(WanderlyColor.ink)
                        .frame(width: 32, height: 32)
                        .background(.ultraThinMaterial, in: Circle())
                }
                .padding(Spacing.md)
            }
            .overlay(alignment: .topLeading) {
                RatingPill(rating: place.rating)
                    .padding(Spacing.md)
            }
    }

    private var title: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(place.name)
                .font(WanderlyFont.sheetTitle)
                .foregroundStyle(WanderlyColor.ink)
            HStack(spacing: Spacing.sm) {
                CategoryBadge(place.category)
                PriceLevelLabel(place.priceLevel)
            }
        }
    }

    private var infoTiles: some View {
        HStack(spacing: Spacing.sm) {
            InfoTile(icon: "clock", value: DurationLabel.humanized(place.estimatedDurationMinutes), label: "Duration")
            InfoTile(icon: "location", value: distanceText, label: "Distance")
            InfoTile(icon: "creditcard", value: place.priceLevel.symbol, label: "Price")
        }
    }

    private var distanceText: String {
        "\(place.distanceKm.formatted(.number.precision(.fractionLength(1)))) km"
    }

    private var tags: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.sm) {
                ForEach(place.tags, id: \.self) { tag in
                    Text(tag)
                        .font(WanderlyFont.footnote)
                        .foregroundStyle(WanderlyColor.ink2)
                        .padding(.horizontal, Spacing.md)
                        .padding(.vertical, Spacing.sm)
                        .background(WanderlyColor.surface, in: Capsule())
                }
            }
        }
    }

    private var footer: some View {
        planButton
            .padding(.horizontal, Spacing.screenEdge)
            .padding(.top, Spacing.md)
            .padding(.bottom, Spacing.lg)
            .background(WanderlyColor.bgElevated)
            .overlay(alignment: .top) {
                Divider()
            }
    }

    @ViewBuilder
    private var planButton: some View {
        if added {
            SecondaryButton("Remove from Plan", icon: "minus.circle.fill", action: toggle)
        } else {
            PrimaryButton("Add to Plan", icon: "plus", action: toggle)
        }
    }

    private func toggle() {
        added.toggle()
        onToggle()
    }
}
