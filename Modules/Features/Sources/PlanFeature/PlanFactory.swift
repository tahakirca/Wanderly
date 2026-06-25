import Domain
import SwiftUI

public enum PlanFactory {
    @MainActor
    public static func make(planStore: PlanStore, onBrowse: @escaping () -> Void) -> some View {
        PlanView(viewModel: PlanViewModel(planStore: planStore), onBrowse: onBrowse)
    }
}
