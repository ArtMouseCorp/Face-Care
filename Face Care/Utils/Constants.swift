import UIKit

let userDefaults = UserDefaults.standard

enum UDKeys {
    static let appLaunchCount: String           = "appLaunchCount"
    static let userName: String                 = "userName"
    static let userAge: String                  = "userAge"
    static let userProblemAreas: String         = "userProblemAreas"
    static let language: String                 = "language"
    static let isOnboardingCompleted: String    = "isOnboardingCompleted"
    static let openedDailyTrainings: String     = "openedDailyTrainings"
    static let completedDailyTrainings: String  = "completedDailyTrainings"
}

enum Keys {
    static let amplitudeApiKey: String      = "f0153fc6e379461837491d09650ec125" // "03fd438d9816aeda67706152fbf980b6"
    static let apphudApiKey: String         = "app_rRGymCYM1iJH3QLqsEePmKN8dzWwzw"
}

enum AmplitudeEvent {
    static let appStartedFirst: String          = "First App Start"
    static let appStarted: String               = "App Started"
    static let appClosed: String                = "App closed"
    static let subscriptionPurchased: String    = "Subscription purchased"
    
    static let languageChanged: String          = "Language changed"
    static let progressOpened: String           = "Progress screen opened"
    static let articlesOpened: String           = "Articles screen opened"
    static let photoAdded: String               = "Photo added to the progress gallery"
    static let pushNotificationsEnabled: String = "Push Notifications Enabled"
    static let pushNotificationsDisabled: String = "Push Notifications Disabled"
    
    internal enum Onboarding {
        static let firstPassed: String          = "First Onboarding Screen Passed"
        static let secondPassed: String         = "Second Onboarding Screen Passed"
        static let thirdPassed: String          = "Third Onboarding Screen Passed"
        static let fourthPassed: String         = "Fourth Onboarding Screen Passed"
        static let fifthPassed: String          = "Fifth Onboarding Screen Passed"
        static let sixthPassed: String          = "Sixth Onboarding Screen Passed"
        static let seventhPassed: String        = "Seventh Onboarding Screen Passed"
        static let eighthPassed: String         = "Eighth Onboarding Screen Passed"
        static let ninthtPassed: String         = "Ninth Onboarding Screen Passed"
    }
    
//    3) Какие параметры поставил
//    4)  Какой уровень выбрал
//    5) Сколько курсов ррошел
//    6) На каком упреждении закрыл курс
//    8) Вышел из курса
//    11) Прошел курс дня до конца
}

public var safeAreaBottomInset: CGFloat {
    let window = UIApplication.shared.windows.first
    let bottomPadding = window!.safeAreaInsets.bottom
    return bottomPadding
}

public func hapticFeedback(_ type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
}



// TODO: - Translate exercises to fr, it ,de, es
// TODO: - currentItem of video is adding two times
// TODO: - Replace contact email
// TODO: - Replace offer Screen json url
// TODO: - Exclusive trainings
// TODO: - Daily trainings cell alpha
// TODO: - AppStoreConnect Subscriptions not working

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
