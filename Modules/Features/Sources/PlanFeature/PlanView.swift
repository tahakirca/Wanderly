import DesignSystem
import Domain
import SwiftUI

struct PlanView: View {
    @StateObject private var viewModel: PlanViewModel
    private let onBrowse: () -> Void

    init(viewModel: PlanViewModel, onBrowse: @escaping () -> Void) {
        _viewModel = StateObject(wrappedValue: viewModel)
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
            PlanSummaryCard(summary: viewModel.summary)
                .listRowInsets(EdgeInsets(top: Spacing.sm, leading: Spacing.screenEdge, bottom: Spacing.xs, trailing: Spacing.screenEdge))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)

            if viewModel.summary.exceedsDayLimit {
                WarningBanner(message: "That's over 10 hours of plans — consider trimming a stop.")
                    .listRowInsets(EdgeInsets(top: Spacing.xs, leading: Spacing.screenEdge, bottom: Spacing.xs, trailing: Spacing.screenEdge))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
            }

            ForEach(viewModel.stops) { stop in
                StopRow(stop: stop)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: Spacing.xs, leading: Spacing.screenEdge, bottom: Spacing.xs, trailing: Spacing.screenEdge))
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
