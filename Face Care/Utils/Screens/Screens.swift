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
    case load               = "LoadingViewController"
    case start              = "StartViewController"
    case onboarding         = "OnboardingViewController"
    case planGeneration     = "PlanGenerationViewController"
    case photoOffer         = "PhotoOfferViewController"
    
    // Home
    case home               = "HomeViewController"
    case settings           = "SettingsViewController"
    case training           = "TrainingViewController"
    case exerciseLoading    = "ExerciseLoadingViewController"
    case exercise           = "ExerciseViewController"
    case trainingEnded      = "TrainingCompletedViewController"
    case captureCover       = "CaptureCoverViewConrtoller"
    
    // Progress
    case progress           = "ProgressViewController"
    case progressSettings   = "ProgressSettingsViewController"
    
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
        case .load,
             .start,
             .onboarding,
             .photoOffer,
             .planGeneration:
            return .Onboarding
            
            // Home
        case .home,
             .settings,
             .training,
             .exerciseLoading,
             .exercise,
             .trainingEnded,
             .captureCover:
            return .Home
            
            // Progress
        case .progress,
             .progressSettings:
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
