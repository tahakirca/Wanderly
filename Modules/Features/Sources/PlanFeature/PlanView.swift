import DesignSystem
import Domain
import SwiftUI

struct PlanView: View {
    @State private var viewModel: PlanViewModel
    private let onBrowse: () -> Void

    init(viewModel: PlanViewModel, onBrowse: @escaping () -> Void) {
        _viewModel = State(initialValue: viewModel)
        self.onBrowse = onBrowse
    }

    var body: some View {
        Group {
            if viewModel.isEmpty {
                emptyState
            } else {
                plan
            }
        }
        .background(WanderlyColor.bg)
        .navigationTitle("My Plan")
        .toolbarBackground(.visible, for: .navigationBar)
        .navigationDestination(for: PlanRoute.self) { _ in
            TripSummaryView(summary: viewModel.summary)
        }
        .toolbar {
            if !viewModel.isEmpty {
                EditButton()
            }
        }
        .task { await viewModel.observe() }
    }

    private var plan: some View {
        List {
            Section {
                ForEach(Array(viewModel.stops.enumerated()), id: \.element.id) { index, stop in
                    StopRow(stop: stop, isFirst: index == 0, isLast: index == viewModel.stops.count - 1)
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(
                            top: 0, leading: Spacing.screenEdge, bottom: 0, trailing: Spacing.screenEdge
                        ))
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                viewModel.remove(stop)
                            } label: {
                                Label("Remove", systemImage: "trash")
                            }
                        }
                }
                .onMove { source, destination in
                    viewModel.move(from: source, to: destination)
                }
            } header: {
                summaryHeader
                    .listRowInsets(EdgeInsets())
                    .textCase(nil)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .safeAreaInset(edge: .bottom) {
            reviewButton
        }
        .overlay(alignment: .bottom) {
            undoSnackbar
        }
    }

    private var summaryHeader: some View {
        VStack(spacing: Spacing.md) {
            PlanSummaryCard(summary: viewModel.summary)
            if viewModel.summary.exceedsDayLimit {
                WarningBanner(message: "That's over 10 hours of plans — consider trimming a stop.")
            }
        }
        .padding(.horizontal, Spacing.screenEdge)
        .padding(.top, Spacing.sm)
        .padding(.bottom, Spacing.md)
        .frame(maxWidth: .infinity)
        .background(WanderlyColor.bg)
    }

    private var reviewButton: some View {
        NavigationLink(value: PlanRoute.summary) {
            HStack(spacing: Spacing.sm) {
                Text("Review trip")
                Image(systemName: "arrow.right")
            }
            .font(WanderlyFont.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 54)
            .background(WanderlyColor.teal, in: RoundedRectangle(cornerRadius: Radius.button))
            .shadow(.primaryButton)
        }
        .padding(.horizontal, Spacing.screenEdge)
        .padding(.bottom, Spacing.sm)
    }

    @ViewBuilder
    private var undoSnackbar: some View {
        if let removed = viewModel.recentlyRemoved {
            Snackbar(message: "Removed \(removed.place.name)") {
                viewModel.undoRemove()
            }
            .padding(.horizontal, Spacing.screenEdge)
            .padding(.bottom, 88)
            .task(id: removed.id) {
                try? await Task.sleep(for: .seconds(4.5))
                if viewModel.recentlyRemoved?.id == removed.id {
                    viewModel.recentlyRemoved = nil
                }
            }
        }
    }

    private var emptyState: some View {
        EmptyStateView(
            icon: "map",
            title: "No stops yet",
            message: "Browse places in Explore and add the ones you'd like to visit.",
            actionTitle: "Browse places",
            action: onBrowse
        )
    }
}
