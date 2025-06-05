# MetMuseumApp

![SwiftUI](https://img.shields.io/badge/SwiftUI-%23FF5722.svg?style=for-the-badge&logo=swift&logoColor=white)

A SwiftUI application that explores the Metropolitan Museum of Art’s collection using their [public API](https://metmuseum.github.io). The app showcases modern Swift development with async/await, MVVM architecture, and advanced SwiftUI techniques.

## Features

- **Welcome Screen**: A friendly onboarding experience greets users before entering the app.
- **Tab-based Navigation**: The main interface uses a TabView with three tabs:
  - **Artworks of the Day**: Discover 5 random artworks from the MET collection, fetched dynamically from the API. Tap any artwork to access a dedicated zoom view.
  - **Artwork Zoom View**: Examine artworks in detail with pinch-to-zoom and rotation gestures for an immersive experience. Images are cached for performance.
  - **All Artworks List**: Browse the entire MET collection with infinite scrolling and a powerful search to find your favorite pieces. All images are cached locally for smooth browsing.
  - **Membership Cards**: Create a (fictional) membership card to access the museum, complete with a generated QR code. Cards are persisted using SwiftData.
- **Modern SwiftUI Patterns**: Built with the MVVM pattern and the new `@Observable` protocol for reactive UI updates.
- **Persistence**: Membership cards are stored locally with SwiftData.
- **Unit Testing**: Key logic is covered by unit tests using SwiftTesting.

## Architecture & Patterns

- **MVVM**: Clean separation of models, view models, and views for maintainability.
- **@Observable**: All stateful models use the new SwiftUI observation protocol.
- **Async/Await**: All API calls leverage Swift’s modern concurrency features for a responsive UI.
- **Image Caching**: Artwork images are cached to disk for fast, efficient browsing.

## Getting Started

### Prerequisites

- Xcode 17 or later
- iOS 17 or later
- Swift 5.9

### Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/aitorballes/METmuseum.git
   cd RecipeApp
   ```
2. **Open in Xcode**:

   ```bash
   open RecipeApp.xcodeproj
   ```
3. **Run** on Simulator or Device (⌘R).

## Project Structure

```
RecipeApp/
├── Resources              # App assets and icons, sounds and jsons
├── Models/                # @Model data models with SwiftData, DTOs and Models
├── ViewModels/            # @Observable view models
├── Views/                 # SwiftUI views
├── Repositories/          # Network repository
└── Tests/                 # SwiftTesting unit tests
```

## Testing

Run the unit tests in Xcode (`⌘U`) to verify models, persistence, and view models are working as expected.

## About the MET Museum API

This app uses the [Metropolitan Museum of Art Collection API](https://metmuseum.github.io) to access over 470,000 artworks. All images and data are provided under the [Creative Commons Zero license](https://creativecommons.org/publicdomain/zero/1.0/).

## Screenshots

<p align="center">
  <img src="Screenshots/1. Icon.png" alt="App Icon" width="300" />
  <img src="Screenshots/2. Splashscreen.png" alt="Splash Screen" width="300" />
  <img src="Screenshots/3. WelcomeView.png" alt="Welcome View" width="300" />
  <img src="Screenshots/4. HomeView.png" alt="Artworks of the Day" width="300" />
  <img src="Screenshots/5. ZoomView.png" alt="Artwork Zoom View" width="300" />
  <img src="Screenshots/6. ExploreView.png" alt="All Artworks List" width="300" />
  <img src="Screenshots/7. FormView.png" alt="Create Membership Card" width="300" />
  <img src="Screenshots/8. CardListView.png" alt="Membership Cards List" width="300" />
</p>

---

**Author:** Aitor Ballesteros  
**Contact:** aitorballesteros@gmail.com

