import Foundation

class State {
    
    // MARK: - Variables
    
    public static var shared: State = State()
    
    private var appLaunch: Int = 0
    public var isSubscribed: Bool = false
    private var offer: Offer?
    
    public var tabBarController: TabBarController = TabBarController()
    private var currenctScreen: String = ""
    
    private var userInfo: UserInfo = UserInfo()
    
    internal struct UserInfo {
        public var problemAreas: [Int] = []
        public var name: String = ""
        public var age: Int = 0
    }
    
    // MARK: - Functions
    
    // MARK: - App launches
    
    public func newAppLaunch() {
        self.appLaunch = self.getAppLaunchCount() + 1
        userDefaults.set(self.appLaunch, forKey: UDKeys.appLaunchCount)
        if self.isFirstLaunch() {
            self.setCustomLanguageChange(to: false)
            self.watchedFreeVideo(false)
        }
    }
    
    public func getAppLaunchCount() -> Int {
        self.appLaunch = userDefaults.integer(forKey: UDKeys.appLaunchCount)
        return self.appLaunch
    }
    
    public func isFirstLaunch() -> Bool {
        return self.appLaunch == 1
    }
    
    // MARK: - First Video
    
    public func watchedFreeVideo(_ bool: Bool = true) {
        userDefaults.set(!bool, forKey: UDKeys.isFreeVideoAvailable)
    }
    
    public func isFreeVideoAvailable() -> Bool {
        userDefaults.bool(forKey: UDKeys.isFreeVideoAvailable)
    }
    
    // MARK: - Offer
    
    public func setOffer(to offer: Offer) {
        self.offer = offer
    }
    
    public func getOffer() -> Offer {
        guard let offer = self.offer else {
            return .defaultOffer
        }
        return offer

    }
    
    // MARK: - Language
    
    public func setCustomLanguageChange(to bool: Bool) {
        userDefaults.set(bool, forKey: UDKeys.isCustomLanguageChange)
    }
    
    public func isCustomLanguageChange() -> Bool {
        return userDefaults.bool(forKey: UDKeys.isCustomLanguageChange)
    }
    
    public func getLanguage() -> Language.Code {
        
        var code = Bundle.main.preferredLocalizations.first ?? "en"
        
        if self.isCustomLanguageChange() {
            code = userDefaults.string(forKey: UDKeys.language) ?? "en"
        }
        
        return Language.Code.init(code)
    }
    
    public func setLanguage(to languageCode: Language.Code) {
        userDefaults.set(languageCode.rawValue, forKey: UDKeys.language)
        
        Article.getAll()
        FaceArea.getAll()
        Training.Exclusive.localizeTrainings()
        Training.Daily.localizeTrainings()
    }
    
    // MARK: - Problem areas
    
    public func getProblemAreas() -> [Int] {
        self.userInfo.problemAreas = userDefaults.array(forKey: UDKeys.userProblemAreas) as? [Int] ?? []
        return self.userInfo.problemAreas
    }
    
    public func clearProblemAreas() {
        self.userInfo.problemAreas.removeAll()
        userDefaults.set(self.userInfo.problemAreas, forKey: UDKeys.userProblemAreas)
    }
    
    public func updateProblemAreas(to elements: [Int]) {
        self.userInfo.problemAreas = elements
        userDefaults.set(self.userInfo.problemAreas, forKey: UDKeys.userProblemAreas)
    }
    
    public func addProblemArea(_ element: Int) {
        self.userInfo.problemAreas.append(element)
        userDefaults.set(self.userInfo.problemAreas, forKey: UDKeys.userProblemAreas)
    }
    
    public func removeProblemArea(_ element: Int) {
        if let index = self.userInfo.problemAreas.firstIndex(of: element) {
            self.userInfo.problemAreas.remove(at: index)
            userDefaults.set(self.userInfo.problemAreas, forKey: UDKeys.userProblemAreas)
        }
    }
    
    // MARK: - Name
    
    public func saveUserName(_ name: String) {
        self.userInfo.name = name
        userDefaults.set(name, forKey: UDKeys.userName)
    }
    
    public func getUserName() -> String {
        self.userInfo.name = userDefaults.string(forKey: UDKeys.userName) ?? ""
        return self.userInfo.name
    }
    
    // MARK: - Age
    
    public func saveUserAge(_ age: Int) {
        self.userInfo.age = age
        userDefaults.set(age, forKey: UDKeys.userAge)
    }
    
    public func getUserAge() -> Int {
        self.userInfo.age = userDefaults.integer(forKey: UDKeys.userAge)
        return self.userInfo.age
    }
    
    // MARK: - Current screen
    
    public func setCurrentScreen(to screen: String) {
        self.currenctScreen = screen
    }
    
    public func getCurrentScreen() -> String {
        return self.currenctScreen
    }
    
    // MARK: - Onboarding
    
    public func isOnboardingCompleted() -> Bool {
        return userDefaults.bool(forKey: UDKeys.isOnboardingCompleted)
        
    }
    
    public func completeOnboarding() {
        userDefaults.set(true, forKey: UDKeys.isOnboardingCompleted)
    }
    
    // MARK: - Open daily trainings
    
    public func setOpenedDailyTrainingNumber(to number: Int) {
        userDefaults.set(number, forKey: UDKeys.openedDailyTrainingNumber)
    }
    
    public func getOpenedDailyTrainingNumber() -> Int {
        return userDefaults.integer(forKey: UDKeys.openedDailyTrainingNumber)
    }
    
    public func setCompletedDailyTrainingDate(to date: Date) {
        userDefaults.set(date.timeIntervalSince1970, forKey: UDKeys.lastCompletedTrainingDate)
    }
    
    public func getCompletedDailyTrainingDate() -> Date {
        return Date(timeIntervalSince1970: userDefaults.double(forKey: UDKeys.lastCompletedTrainingDate))
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
