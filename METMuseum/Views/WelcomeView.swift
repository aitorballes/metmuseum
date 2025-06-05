import SwiftUI

struct WelcomeView: View {
    @Environment(NavigationManager.self) var navigationManager
    @AppStorage("goToContentTabView") private var goToContentTabView = false
    
    var body: some View {
        if goToContentTabView {
            ContentTabView()
        } else {
            NavigationStack {
                VStack {
                    Image(systemName: "paintpalette")
                        .resizable()
                        .frame(width: 100, height: 100)

                    Text("Welcome to the MET")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()

                    Text(
                        "Explore the vast collection of art from around the world."
                    )
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 100)

                    Button {
                        goToContentTabView.toggle()
                        
                    } label: {
                        Text("Get Started")
                            .frame(maxWidth: .infinity)

                    }
                    .padding(.top, 100)
                    .buttonStyle(.borderedProminent)

                    Text("Developed with MET API")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                }
                .padding()
                .multilineTextAlignment(.center)
            }
        }       

    }
}

#Preview {
    WelcomeView()
}
