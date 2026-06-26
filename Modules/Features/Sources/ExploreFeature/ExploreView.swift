import DesignSystem
import Domain
import SwiftUI

struct ExploreView: View {
    @State private var viewModel: ExploreViewModel
    @Environment(ThemeController.self) private var theme
    @State private var selectedPlace: Place?

    init(viewModel: ExploreViewModel) {
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        ScrollView {
            categoryChips
                .padding(.vertical, Spacing.sm)

            cards
                .padding(.horizontal, Spacing.screenEdge)
                .padding(.bottom, Spacing.xxxl)
        }
        .background(WanderlyColor.bg)
        .navigationTitle("Explore")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                ThemeToggleButton(theme: theme)
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search places")
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
