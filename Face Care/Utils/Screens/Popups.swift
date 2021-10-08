import UIKit

public enum Popup: String, StoryboardScreen {
    
    // Main
    case exerciseInfo   = "ExerciseInfoPopup"
    
    // Progress
    case image          = "ImagePopup"
    case demo           = "ProgressDemoPopup"
    
}

extension Popup {
    
    public var id: String {
        return self.rawValue
    }
    
    public var location: Storyboard {
        switch self {
            
            // Home
        case .exerciseInfo:
            return .Home
        
            // Progress
        case .image, .demo:
            return .Progress
            
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
