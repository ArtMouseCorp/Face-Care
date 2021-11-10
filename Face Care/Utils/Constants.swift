import UIKit

let userDefaults = UserDefaults.standard

enum UDKeys {
    static let appLaunchCount: String               = "appLaunchCount"
    static let userName: String                     = "userName"
    static let userAge: String                      = "userAge"
    static let userProblemAreas: String             = "userProblemAreas"
    static let language: String                     = "language"
    static let isOnboardingCompleted: String        = "isOnboardingCompleted"
    static let openedDailyTrainings: String         = "openedDailyTrainings"
    static let completedDailyTrainings: String      = "completedDailyTrainings"
    static let lastCompletedTrainingDate: String    = "lastCompletedTrainingDate"
    static let openedDailyTrainingNumber: String    = "openedDailyTrainingNumber"
    static let isCustomLanguageChange: String       = "isCustomLanguageChange"
}

enum Keys {
    static let amplitudeApiKey: String              = "f0153fc6e379461837491d09650ec125"
    static let apphudApiKey: String                 = "app_veTtQ46y9Pot9hxzzGJ9U8GCpFT3W2"
    static let appleAppId: String                   = "1588250473"
    static let appsFlyerDevKey: String              = "DdrHnCFjM89FpViyQPBs8Z"
}

enum AmplitudeEvent {
    static let appStartedFirst: String              = "First App Start"
    static let appStarted: String                   = "App Started"
    static let appClosed: String                    = "App closed"
    static let subscriptionPurchased: String        = "Subscription purchased"
    
    static let languageChanged: String              = "Language changed"
    static let progressOpened: String               = "Progress screen opened"
    static let articlesOpened: String               = "Articles screen opened"
    static let photoAdded: String                   = "Photo added to the progress gallery"
    static let pushNotificationsEnabled: String     = "Push Notifications Enabled"
    static let pushNotificationsDisabled: String    = "Push Notifications Disabled"
    
    internal enum Onboarding {
        static let firstPassed: String              = "First Onboarding Screen Passed"
        static let secondPassed: String             = "Second Onboarding Screen Passed"
        static let thirdPassed: String              = "Third Onboarding Screen Passed"
        static let fourthPassed: String             = "Fourth Onboarding Screen Passed"
        static let fifthPassed: String              = "Fifth Onboarding Screen Passed"
        static let sixthPassed: String              = "Sixth Onboarding Screen Passed"
        static let seventhPassed: String            = "Seventh Onboarding Screen Passed"
        static let eighthPassed: String             = "Eighth Onboarding Screen Passed"
        static let ninthtPassed: String             = "Ninth Onboarding Screen Passed"
    }
    
//    3)  Какие параметры поставил
//    4)  Какой уровень выбрал
//    5)  Сколько курсов прошел
//    6)  На каком упреждении закрыл курс
//    8)  Вышел из курса
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
