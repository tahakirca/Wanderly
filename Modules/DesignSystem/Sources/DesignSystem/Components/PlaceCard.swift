import SwiftUI
import Domain

/// The rich Explore card: image with overlays, title, description and a meta row.
/// The whole card is tappable; the Add button toggles plan membership separately.
public struct PlaceCard: View {
    private let place: Place
    private let isAdded: Bool
    private let onTap: () -> Void
    private let onTogglePlan: () -> Void

    private let addButtonInset: CGFloat = 14
    // The add button sits half over the image's bottom edge (it's 44pt tall).
    private let addButtonOverhang: CGFloat = 22

    public init(
        place: Place,
        isAdded: Bool,
        onTap: @escaping () -> Void,
        onTogglePlan: @escaping () -> Void
    ) {
        self.place = place
        self.isAdded = isAdded
        self.onTap = onTap
        self.onTogglePlan = onTogglePlan
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            cover
            details
        }
        .background(WanderlyColor.bgElevated)
        .clipShape(RoundedRectangle(cornerRadius: Radius.card))
        .shadow(.card)
        .contentShape(RoundedRectangle(cornerRadius: Radius.card))
        .onTapGesture(perform: onTap)
    }

    private var cover: some View {
        PlaceImage(url: place.imageURL)
            .frame(height: CardMetrics.imageHeight)
            .frame(maxWidth: .infinity)
            .clipped()
            .overlay(alignment: .topLeading) {
                CategoryBadge(place.category)
                    .padding(Spacing.md)
            }
            .overlay(alignment: .topTrailing) {
                RatingPill(rating: place.rating)
                    .padding(Spacing.md)
            }
            .overlay(alignment: .bottomTrailing) {
                AddPlanButton(isAdded: isAdded, action: onTogglePlan)
                    .padding(.trailing, addButtonInset)
                    .offset(y: addButtonOverhang)
            }
    }

    private var details: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            Text(place.name)
                .font(WanderlyFont.headline)
                .foregroundStyle(WanderlyColor.ink)

            Text(place.description)
                .font(WanderlyFont.subhead)
                .foregroundStyle(WanderlyColor.ink2)
                .lineLimit(2)
                .lineSpacing(2)

            metaRow
        }
        .padding(.horizontal, Spacing.lg)
        .padding(.top, Spacing.xxl)
        .padding(.bottom, Spacing.lg)
    }

    private var metaRow: some View {
        HStack(spacing: Spacing.md) {
            DurationLabel(minutes: place.estimatedDurationMinutes)
            HStack(spacing: Spacing.xs) {
                Image(systemName: "location")
                    .font(.system(size: 12))
                Text("\(place.distanceKm, format: .number.precision(.fractionLength(1))) km")
            }
            .font(WanderlyFont.footnote)
            .foregroundStyle(WanderlyColor.ink2)

            Spacer()
            PriceLevelLabel(place.priceLevel)
        }
    }
}

#Preview {
    PlaceCard(
        place: .preview,
        isAdded: false,
        onTap: {},
        onTogglePlan: {}
    )
    .padding()
    .background(WanderlyColor.bg)
}
