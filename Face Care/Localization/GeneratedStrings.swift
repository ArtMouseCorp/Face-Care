//// swiftlint:disable all
//// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen
//
//import Foundation
//
//// swiftlint:disable superfluous_disable_command file_length implicit_return
//
//// MARK: - Strings
//
//// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
//// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
//internal enum L {
//
//  internal enum Alert {
//    internal enum Action {
//      /// Cancel
//      internal static let cancel = "alert.action.cancel"
//      /// Generate
//      internal static let generate = "alert.action.generate"
//      /// Ok
//      internal static let ok = "alert.action.ok"
//      /// Yes
//      internal static let yes = "alert.action.yes"
//    }
//    internal enum Connection {
//      /// No internet connection. Please connect to the network and try again.
//      internal static let message = "alert.connection.message"
//      /// No internet connection
//      internal static let title = "alert.connection.title"
//    }
//    internal enum Mail {
//      /// Mail services are not available
//      internal static let title = "alert.mail.title"
//    }
//    internal enum NotSubscriber {
//      /// Unfortunately, you cannot restore your purchase because you do not have an active subscription.
//      internal static let message = "alert.notSubscriber.message"
//      /// Not restorable
//      internal static let title = "alert.notSubscriber.title"
//    }
//    internal enum ProblemArea {
//      /// To generate a course, you need to select at least one part of the face
//      internal static let message = "alert.problemArea.message"
//      /// Choose a part of the face
//      internal static let title = "alert.problemArea.title"
//    }
//    internal enum ResetProgressSure {
//      /// Your personal course will be re-generated and you can start over
//      internal static let message = "alert.resetProgressSure.message"
//      /// Are you sure?
//      internal static let title = "alert.resetProgressSure.title"
//    }
//    internal enum Restored {
//      /// You have successfully restored your subscription. All functionality is now available to you.
//      internal static let message = "alert.restored.message"
//      /// Restored
//      internal static let title = "alert.restored.title"
//    }
//    internal enum Subscribed {
//      /// You are already subscribed. All functionality is available to you.
//      internal static let message = "alert.subscribed.message"
//      /// Subscribed
//      internal static let title = "alert.subscribed.title"
//    }
//    internal enum Training {
//      /// Are you sure you want to quit?
//      internal static let title = "alert.training.title"
//    }
//  }
//
//  internal enum Atricles {
//    /// Useful articles
//    internal static let title = "atricles.title"
//  }
//
//  internal enum FacePart {
//    /// Cheekbones and cheeks
//    internal static let cheekbonesAndCheeks = "facePart.cheekbonesAndCheeks"
//    /// Chin
//    internal static let chin = "facePart.chin"
//    /// Eyes
//    internal static let eyes = "facePart.eyes"
//    /// Forehead
//    internal static let forehead = "facePart.forehead"
//    /// Lymph
//    internal static let lymph = "facePart.lymph"
//    /// Neck
//    internal static let neck = "facePart.neck"
//  }
//
//  internal enum Home {
//    /// Day %d
//    internal static let day = "home.day"
//    /// Exclusive trainings
//    internal static let exclusiveTrainings = "home.exclusiveTrainings"
//    /// List of exercises
//    internal static let exercisesList = "home.exercisesList"
//    /// Recommended for today
//    internal static let title = "home.title"
//    internal enum Duration {
//      internal enum Minutes {
//        /// %d minutes
//        internal static let five = "home.duration.minutes.five"
//        /// %d minute
//        internal static let one = "home.duration.minutes.one"
//        /// %d minutes
//        internal static let two = "home.duration.minutes.two"
//      }
//    }
//  }
//
//  internal enum Onboarding {
//    /// Upload photo
//    internal static let loadImage = "onboarding.loadImage"
//    /// Get a personalized course
//    internal static let personalPlan = "onboarding.personalPlan"
//    internal enum Features {
//      /// Clean skin
//      internal static let first = "onboarding.features.first"
//      /// Healthy complexion
//      internal static let second = "onboarding.features.second"
//      /// All-day energy boost
//      internal static let third = "onboarding.features.third"
//    }
//    internal enum OnboardingButton {
//      /// Continue
//      internal static let `continue` = "onboarding.onboardingButton.continue"
//      /// Yes, but only in the eye area
//      internal static let eyesWrinkles = "onboarding.onboardingButton.eyesWrinkles"
//      /// No
//      internal static let no = "onboarding.onboardingButton.no"
//      /// Start
//      internal static let start = "onboarding.onboardingButton.start"
//      /// Yes
//      internal static let yes = "onboarding.onboardingButton.yes"
//      internal enum Sleep {
//        /// More than 8 hours
//        internal static let long = "onboarding.onboardingButton.sleep.long"
//        /// 7-8 hours
//        internal static let normal = "onboarding.onboardingButton.sleep.normal"
//        /// Less than 7 hours
//        internal static let short = "onboarding.onboardingButton.sleep.short"
//      }
//    }
//    internal enum Screen {
//      internal enum Title {
//        /// What's your name?
//        internal static let eighth = "onboarding.screen.title.eighth"
//        /// Do you notice wrinkles on your face when you smile or laugh?
//        internal static let fifth = "onboarding.screen.title.fifth"
//        /// Do you want to look younger?
//        internal static let first = "onboarding.screen.title.first"
//        /// What area of your face would you like to focus on?
//        internal static let fourth = "onboarding.screen.title.fourth"
//        /// How old are you?
//        internal static let ninth = "onboarding.screen.title.ninth"
//        /// Do you want your face to look tighter?
//        internal static let second = "onboarding.screen.title.second"
//        /// How many hours do you usually sleep?
//        internal static let seventh = "onboarding.screen.title.seventh"
//        /// Do you notice wrinkles on your face when it's relaxed?
//        internal static let sixth = "onboarding.screen.title.sixth"
//        /// What is your skin type?
//        internal static let third = "onboarding.screen.title.third"
//      }
//    }
//    internal enum SkinType {
//      /// Combined
//      internal static let combined = "onboarding.skinType.combined"
//      /// Dry
//      internal static let dry = "onboarding.skinType.dry"
//      /// Oily
//      internal static let fat = "onboarding.skinType.fat"
//      /// Normal
//      internal static let normal = "onboarding.skinType.normal"
//    }
//    internal enum Start {
//      /// Face Care course - your way to natural beauty and youthfulness
//      internal static let description = "onboarding.start.description"
//      /// Welcome to
//      internal static let welcome = "onboarding.start.welcome"
//    }
//  }
//
//  internal enum PlanGeneration {
//    /// Analysis of problem areas
//    internal static let first = "planGeneration.first"
//    /// Skin analysis
//    internal static let second = "planGeneration.second"
//    /// Choosing facial exercises according to your needs
//    internal static let third = "planGeneration.third"
//    /// Preparing a personal training plan
//    internal static let title = "planGeneration.title"
//  }
//
//  internal enum Progress {
//    /// Add photo
//    internal static let addImage = "progress.addImage"
//    /// Watch a demonstration
//    internal static let demonstration = "progress.demonstration"
//    /// Progress Gallery
//    internal static let gallery = "progress.gallery"
//    /// Daily goal
//    internal static let goal = "progress.goal"
//    /// For best results, exercise every day.
//    internal static let subtitle = "progress.subtitle"
//    /// My progress
//    internal static let title = "progress.title"
//    internal enum Settings {
//      /// Problem areas
//      internal static let problemAreas = "progress.settings.problemAreas"
//      /// You can reset your days, history, and personal course settings to zero and start again
//      internal static let resetDescription = "progress.settings.resetDescription"
//      /// Progress Settings
//      internal static let title = "progress.settings.title"
//      internal enum ProgressButton {
//        /// Zero Progress
//        internal static let resetProgress = "progress.settings.progressButton.resetProgress"
//      }
//    }
//  }
//
//  internal enum Settings {
//    /// Contact us
//    internal static let contact = "settings.contact"
//    /// Restore purchases
//    internal static let restore = "settings.restore"
//    /// Settings
//    internal static let title = "settings.title"
//    internal enum Language {
//      /// English
//      internal static let english = "settings.language.english"
//      /// French
//      internal static let french = "settings.language.french"
//      /// German
//      internal static let german = "settings.language.german"
//      /// Italian
//      internal static let italian = "settings.language.italian"
//      /// Russian
//      internal static let russian = "settings.language.russian"
//      /// Spanish
//      internal static let spanish = "settings.language.spanish"
//      /// Language
//      internal static let title = "settings.language.title"
//    }
//  }
//
//  internal enum Subscription {
//    /// Plan information
//    internal static let planInfo = "subscription.planInfo"
//    /// Privacy Policy
//    internal static let privacy = "subscription.privacy"
//    /// Terms of Use
//    internal static let termsOfUse = "subscription.termsOfUse"
//    internal enum Interval {
//      internal enum Day {
//        /// days
//        internal static let five = "subscription.interval.day.five"
//        /// day
//        internal static let one = "subscription.interval.day.one"
//        /// days
//        internal static let two = "subscription.interval.day.two"
//      }
//      internal enum Month {
//        /// months
//        internal static let five = "subscription.interval.month.five"
//        /// month
//        internal static let one = "subscription.interval.month.one"
//        /// months
//        internal static let two = "subscription.interval.month.two"
//      }
//      internal enum Week {
//        /// weeks
//        internal static let five = "subscription.interval.week.five"
//        /// week
//        internal static let one = "subscription.interval.week.one"
//        /// weeks
//        internal static let two = "subscription.interval.week.two"
//      }
//      internal enum Year {
//        /// years
//        internal static let five = "subscription.interval.year.five"
//        /// year
//        internal static let one = "subscription.interval.year.one"
//        /// years
//        internal static let two = "subscription.interval.year.two"
//      }
//    }
//  }
//
//  internal enum Training {
//    /// Training is over
//    internal static let completed = "training.completed"
//    /// Exercise %d:\n%@
//    internal static let exercise = "training.exercise"
//    /// Start training
//    internal static let start = "training.start"
//    /// Take a photo
//    internal static let takeImage = "training.takeImage"
//  }
//}
//// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
//// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces
//
//// MARK: - Implementation Details
//
//extension L10n {
//  private static func tr(_ table: String, _ key: String, _ args: CVarArg... -> String {
//      let path = Bundle.main.path(forResource: State.shared.getLanguage(.rawValue, ofType: "lproj"
//      let bundle = Bundle(path: path! ?? Bundle.main
//      let format = bundle.localizedString(forKey: key, value: nil, table: table
//      return String(format: format, arguments: args
//  }
//}
//
//// swiftlint:disable convenience_type
//private final class BundleToken {
//  static let bundle: Bundle = {
//    #if SWIFT_PACKAGE
//    return Bundle.module
//    #else
//    return Bundle(for: BundleToken.self
//    #endif
//  }(
//}
//// swiftlint:enable convenience_type
