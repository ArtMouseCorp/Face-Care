import Foundation

class State {
    
    // MARK: - Variables
    public static var shared: State = State()
    
    private var appLaunch: Int = 0
    public var tabBarController: TabBarController = TabBarController()
    private var problemAreas: [Int] = []
    
    // MARK: - Functions
    
    // MARK: - App launches
    
    public func newAppLaunch() {
        self.appLaunch = self.getAppLaunchCount() + 1
        userDefaults.set(self.appLaunch, forKey: UDKeys.appLaunchCount)
    }
    
    public func getAppLaunchCount() -> Int {
        self.appLaunch = userDefaults.integer(forKey: UDKeys.appLaunchCount)
        return self.appLaunch
    }
    
    public func isFirstLaunch() -> Bool {
        return self.appLaunch == 1
    }
    
    // MARK: - Language
    
    public func getLanguage() -> Language.Code {
        let code = userDefaults.string(forKey: UDKeys.language) ?? "en"
        return Language.Code.init(code)
    }
    
    public func setLanguage(to languageCode: Language.Code) {
        userDefaults.set(languageCode.rawValue, forKey: UDKeys.language)
    }
    
    // MARK: - Problem areas
    
    public func addProblemArea(_ element: Int) {
        problemAreas.append(element)
        userDefaults.set(problemAreas, forKey: UDKeys.problemAreas)
    }
    
    public func removeProblemArea(_ element: Int) {
        if let index = problemAreas.firstIndex(of: element) {
            problemAreas.remove(at: index)
        }
        userDefaults.set(problemAreas, forKey: UDKeys.problemAreas)
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
