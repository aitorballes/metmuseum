import Foundation
import Observation

@Observable
final class NavigationManager {
    static let shared = NavigationManager()
    
    enum NavigationPath{
        case welcome
        case splashscreen
        case home
    }
    
    var currentPath: NavigationPath = .splashscreen
}
    
