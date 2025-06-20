import Foundation
import SwiftUI

struct SplashView: View {
    @Environment(NavigationManager.self) var navigationManager:
        NavigationManager
    @State private var progress: CGFloat = 0

    var body: some View {
        VStack {
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()

            Capsule()
                .fill(Color.gray)
                .frame(width: 200, height: 10)
                .overlay {
                    HStack {
                        Capsule()
                            .frame(width: progress, height: 10)
                            .foregroundColor(.accentColor)
                        Spacer()

                    }
                }
                .task {
                    withAnimation(.linear(duration: 3)) {
                        progress = 200
                    }

                    withAnimation {
                        navigationManager.currentView = .welcome
                    }
                }
        }
    }
}

#Preview {
    SplashView()
}
