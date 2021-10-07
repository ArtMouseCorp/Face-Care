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
    
    private var openedDailyTrainings: [Bool] = [true, false, false, false, false, false, false]
    
    
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
    
    public func getLanguage() -> Language.Code {
        let code = userDefaults.string(forKey: UDKeys.language) ?? "en"
        return Language.Code.init(code)
    }
    
    public func setLanguage(to languageCode: Language.Code) {
        userDefaults.set(languageCode.rawValue, forKey: UDKeys.language)
        
        Article.getAll()
        FaceArea.getAll()
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
    
    public func getOpenedDailyTrainings() -> [Bool] {
        self.openedDailyTrainings = userDefaults.array(forKey: UDKeys.openedDailyTrainings) as? [Bool] ?? [true, false, false, false, false, false, false]
        return self.openedDailyTrainings
    }
    
    public func clearOpenedDailyTrainings() {
        self.openedDailyTrainings = [true, false, false, false, false, false, false]
        userDefaults.set(openedDailyTrainings, forKey: UDKeys.openedDailyTrainings)
    }
    
    public func completeDailyTraining(number: Int) {
        
        if number > getCompletedDailyTrainings() {
            userDefaults.set(number, forKey: UDKeys.completedDailyTrainings)            
        }
        
        guard number != 7 else { return }
        self.openedDailyTrainings = getOpenedDailyTrainings()
        self.openedDailyTrainings[number] = true
        userDefaults.set(openedDailyTrainings, forKey: UDKeys.openedDailyTrainings)
    }
    
    public func getCompletedDailyTrainings() -> Int {
        return userDefaults.integer(forKey: UDKeys.completedDailyTrainings)
    }
    
    public func clearCompletedDailyTrainings() {
        userDefaults.set(0, forKey: UDKeys.completedDailyTrainings)
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
