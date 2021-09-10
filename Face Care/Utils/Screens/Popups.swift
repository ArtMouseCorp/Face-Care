import UIKit

public enum Popup: String, StoryboardScreen {
    
    // Main
    case mainPopup  = "MainPopup"
    case exercises  = "ExercisePopupViewController"
    
    // Progress
    case image      = "ImagePopup"

    // Articles
    
}

extension Popup {
    
    public var id: String {
        return self.rawValue
    }
    
    public var location: Storyboard {
        switch self {
            
            // Main
        case .mainPopup:
            return .Main
            
            // Home
        case .exercises:
            return .Home
        
            // Progress
        case .image:
            return .Progress
            
            // Articles
            
            
        }
    }
    
    public var storyboard: UIStoryboard {
        return UIStoryboard(name: self.location.rawValue, bundle: nil)
    }
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */
