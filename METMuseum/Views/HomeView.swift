import SwiftData
import SwiftUI

struct HomeView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: HomeViewModel

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {

                Text(
                    "Explore a curated selection of artworks from the MET's vast collection."
                )
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.randomArtObjects) { artObject in
                            NavigationLink(value: artObject) {
                                CachedImageView(
                                    imageUrl: artObject.imageSmall,
                                    size: 250
                                )
                                .cornerRadius(10)
                            }

                        }
                    }
                }
                .overlay {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .frame(width: 250, height: 250)
                            .tint(.accentColor)
                            .padding()
                    }
                }
                .frame(height: 250)

                Text(
                    #""Art is what you can get away with."                      - Andy Warhol"#
                )
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            }
            .navigationTitle("Artworks of the day")
            .navigationDestination(for: ArtObjectModel.self) { artObject in
                ImageZoomView(artObject: artObject)
            }
                    

            Spacer()

        }
        .task {
            await viewModel.getRandomArtObjects()
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(dataRepository: DataRepositoryTest()))
}
