import DesignSystem
import Domain
import SwiftUI

struct ExploreView: View {
    @StateObject private var viewModel: ExploreViewModel
    @EnvironmentObject private var theme: ThemeController
    @State private var selectedPlace: Place?

    init(viewModel: ExploreViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            cards
                .padding(.horizontal, Spacing.screenEdge)
                .padding(.top, Spacing.md)
                .padding(.bottom, Spacing.xxxl)
        }
        .background(WanderlyColor.bg)
        .safeAreaInset(edge: .top, spacing: 0) {
            topBar
        }
        .toolbar(.hidden, for: .navigationBar)
        .sheet(item: $selectedPlace) { place in
            PlaceDetailSheet(
                place: place,
                isAdded: viewModel.isInPlan(place),
                onToggle: { viewModel.togglePlan(place) }
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.hidden)
        }
        .task { await viewModel.load() }
        .task { await viewModel.observePlan() }
    }

    private var topBar: some View {
        VStack(spacing: Spacing.md) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: Spacing.xs) {
                    Text("JAIPUR · 1 DAY")
                        .font(WanderlyFont.caption)
                        .tracking(0.5)
                        .foregroundStyle(WanderlyColor.rose)
                    Text("Explore")
                        .font(WanderlyFont.largeTitle)
                        .foregroundStyle(WanderlyColor.ink)
                }
                Spacer()
                ThemeToggleButton(theme: theme)
            }
            .padding(.horizontal, Spacing.screenEdge)

            searchField
                .padding(.horizontal, Spacing.screenEdge)

            categoryChips
        }
        .padding(.top, Spacing.sm)
        .padding(.bottom, Spacing.md)
        .background(WanderlyColor.bg.ignoresSafeArea(edges: .top))
    }

    private var searchField: some View {
        HStack(spacing: Spacing.sm) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(WanderlyColor.ink3)
            TextField("Search places", text: $viewModel.searchText)
                .font(WanderlyFont.body)
                .autocorrectionDisabled()
            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(WanderlyColor.ink3)
                }
            }
        }
        .padding(.horizontal, Spacing.md)
        .frame(height: 42)
        .background(WanderlyColor.surface, in: Capsule())
    }

    private var categoryChips: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Spacing.sm) {
                CategoryChip(title: "All", symbol: "square.grid.2x2", isSelected: viewModel.selectedCategory == nil) {
                    viewModel.selectedCategory = nil
                }
                ForEach(PlaceCategory.allCases, id: \.self) { category in
                    CategoryChip(category: category, isSelected: viewModel.selectedCategory == category) {
                        viewModel.selectedCategory = category
                    }
                }
            }
            .padding(.horizontal, Spacing.screenEdge)
        }
    }

    @ViewBuilder
    private var cards: some View {
        if viewModel.isLoading {
            VStack(spacing: Spacing.lg) {
                ForEach(0..<4, id: \.self) { _ in
                    SkeletonCard()
                }
            }
        } else if viewModel.visiblePlaces.isEmpty {
            noResults
        } else {
            LazyVStack(spacing: Spacing.lg) {
                ForEach(viewModel.visiblePlaces) { place in
                    PlaceCard(
                        place: place,
                        isAdded: viewModel.isInPlan(place),
                        onTap: { selectedPlace = place },
                        onTogglePlan: { viewModel.togglePlan(place) }
                    )
                }
            }
        }
    }

    private var noResults: some View {
        VStack(spacing: Spacing.md) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 40))
                .foregroundStyle(WanderlyColor.ink3)
            Text("No places found")
                .font(WanderlyFont.headline)
                .foregroundStyle(WanderlyColor.ink2)
        }
        .frame(maxWidth: .infinity)
        .padding(.top, Spacing.xxxl)
    }
}
