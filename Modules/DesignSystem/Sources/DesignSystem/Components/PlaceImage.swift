import SwiftUI
import Kingfisher

/// Remote image with a surface-colored placeholder and a gentle fade-in.
public struct PlaceImage: View {
    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public var body: some View {
        KFImage(url)
            .placeholder {
                WanderlyColor.surface
            }
            .fade(duration: 0.3)
            .resizable()
            .scaledToFill()
    }
}

#Preview {
    PlaceImage(url: URL(string: "https://picsum.photos/seed/wanderly-1/900/700")!)
        .frame(width: 320, height: 172)
        .clipShape(RoundedRectangle(cornerRadius: Radius.card))
        .padding()
}
