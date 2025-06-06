import SwiftUI

struct ArtsObjectsListView: View {
    @Environment(NavigationManager.self) private var navigationManager
    
    @State var viewModel: ArtObjectsViewModel
    @State private var lastOffset: CGFloat = 0
    @State private var showButton = false

    var body: some View {
        @Bindable var navigationManager = navigationManager
        
        NavigationStack (path: $navigationManager.listNavigationPath) {
            ScrollViewReader { scrollProxy in
                ScrollView(showsIndicators: false) {

                    ScrollDetector()

                    LazyVStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.displayedObjects) { artObject in
                            NavigationLink(value: artObject) {
                                RowView(artObject: artObject)
                                    .id(artObject.id)
                                    .padding(.horizontal)
                                    .onAppear {
                                        if viewModel.displayedObjects.last
                                            == artObject
                                        {
                                            Task {
                                                await viewModel
                                                    .loadMoreObjects()
                                            }
                                        }
                                    }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .listStyle(.plain)
                .refreshable {
                    await viewModel.getArtObjects()
                }
                .navigationTitle("Art Objects")
                .navigationDestination(for: ArtObjectModel.self) {
                    artObject in
                    Text(artObject.title)
                        .navigationTitle(artObject.title)
                        .navigationBarTitleDisplayMode(.inline)
                }
                .searchable(
                    text: $viewModel.searchQuery,
                    prompt: "Search..."
                )
                .coordinateSpace(name: "scroll")
                .onScrollPhaseChange { _, _, context in
                    let currentOffset = context.geometry.visibleRect.minY
                    if currentOffset < 0 {
                        withAnimation { showButton = false }
                    } else if currentOffset > 100 {
                        withAnimation { showButton = true }
                    }
                    lastOffset = currentOffset
                }
                .overlay {
                    if viewModel.isLoading {
                        ProgressView()
                            .progressViewStyle(.circular)
                            .tint(.accentColor)
                            .padding()
                    }
                    
                    if viewModel.displayedObjects.isEmpty && !viewModel.isLoading {
                        ContentUnavailableView("Ups..", systemImage: "photo.artframe", description: Text("No art objects found. Please try again later."))
                            
                    }

                    if showButton {
                        Button(action: {
                            if let firstId = viewModel.displayedObjects
                                .first?.id
                            {
                                withAnimation(.easeInOut) {
                                    scrollProxy.scrollTo(
                                        firstId,
                                        anchor: .top
                                    )
                                }
                            }
                        }) {
                            Image(systemName: "arrow.up")
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding()
                        .transition(
                            .move(edge: .bottom).combined(with: .opacity)
                        )
                        .zIndex(1)
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity,
                            alignment: .bottomTrailing
                        )
                    }
                }
            }
        }
        .task {
            if viewModel.displayedObjects.isEmpty {
                await viewModel.getArtObjects()
            }
        }
    }
}
