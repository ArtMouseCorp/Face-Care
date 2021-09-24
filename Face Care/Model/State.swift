import Foundation

struct State {
    
    // MARK: - Variables
    
    private static var appLaunch: Int = 0
    public static var languageCode: Language.Code = Language.Code.en
    public static var tabBarController: TabBarController = TabBarController()
    
    // MARK: - Functions
    
    static func newAppLaunch() {
        self.appLaunch = self.getAppLaunchCount() + 1
        userDefaults.set(self.appLaunch, forKey: UDKeys.appLaunchCount)
    }
    
    public static func getAppLaunchCount() -> Int {
        self.appLaunch = userDefaults.integer(forKey: UDKeys.appLaunchCount)
        return self.appLaunch
    }
    
    public static func isFirstLaunch() -> Bool {
        return self.appLaunch == 1
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
