import UIKit

public protocol StoryboardScreen {
    var id: String { get }
    var location: Storyboard { get }
    var storyboard: UIStoryboard { get }
}

public enum Screen: String, StoryboardScreen {
    
    // Main
    case home       = "HomeViewController"
    
    // Progress
    case progress   = "ProgressViewController"
    
    // Articles
    case articles   = "ArticlesViewController"
    case article    = "ArticleViewController"
    
}

extension Screen {
    
    public var id: String {
        return self.rawValue
    }
    
    public var location: Storyboard {
        switch self {
            
            // Main
        case .home:
            return .Home
            
            // Progress
        case .progress:
            return .Progress
            
            // Articles
        case .articles:
            return .Articles
            
        case .article:
            return .Articles
            
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
