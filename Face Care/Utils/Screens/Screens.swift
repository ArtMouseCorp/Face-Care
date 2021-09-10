import UIKit

public protocol StoryboardScreen {
    var id: String { get }
    var location: Storyboard { get }
    var storyboard: UIStoryboard { get }
}

public enum Screen: String, StoryboardScreen {
    
    // Main
    case tabBar             = "TabBarController"
    
    // Onboarding
    case start              = "StartViewController"
    case onboarding         = "OnboardingViewController"
    case planGeneration     = "PlanGenerationViewController"
    
    // Home
    case home               = "HomeViewController"
    
    // Progress
    case progress           = "ProgressViewController"
    
    // Articles
    case articles           = "ArticlesViewController"
    case article            = "ArticleViewController"
    
}

extension Screen {
    
    public var id: String {
        return self.rawValue
    }
    
    public var location: Storyboard {
        switch self {
            
            // Main
        case .tabBar:
            return .Main
            
            // Onboarding
        case .start,
             .onboarding,
             .planGeneration:
            return .Onboarding
            
            // Home
        case .home:
            return .Home
            
            // Progress
        case .progress:
            return .Progress
            
            // Articles
        case .articles,
             .article:
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
