import UIKit
import CoreData
import IQKeyboardManagerSwift
import Firebase
import Amplitude
import ApphudSDK
import FacebookCore
import FacebookAEM
import AppsFlyerLib
import AppTrackingTransparency

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        State.shared.newAppLaunch()
        
        
        // It enables intelligent text field behavior when the keyboard is covering the text field.
        IQKeyboardManager.shared.enable = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
        // Services connections
        
        integrateApphud()
        integrateAmplitude()
        integrateFirebase()
        integrateFirebaseMessaging(for: application)
        integrateAppsFlyer()
        integrateFacebook(for: application, with: launchOptions)
        
        Amplitude.instance().logEvent(State.shared.isFirstLaunch() ? AmplitudeEvent.appStartedFirst : AmplitudeEvent.appStarted)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        
        AEMReporter.configure(withNetworker: nil, appID: "450010409822978")
        AEMReporter.enable()
        AEMReporter.handle(url)
        
        // Pass DeepLink URL to iOS SDK
        return ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    @objc private func appMovedToBackground() {
        Amplitude.instance().logEvent(AmplitudeEvent.appClosed,
                                      withEventProperties: [
                                        "Closed on screen": State.shared.getCurrentScreen()
                                      ])
    }
    
    // SceneDelegate support - start AppsFlyer SDK
    @objc private func sendLaunch() {
        
        AppEvents.shared.activateApp()
        
        AppsFlyerLib.shared().waitForATTUserAuthorization(timeoutInterval: 60)
        AppsFlyerLib.shared().start()
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization() { status in }
        }
        
        AppsFlyerLib.shared().logEvent(AFEventStartTrial, withValues: nil)
    }
    
    // MARK: - Services integration functions
    
    private func integrateFirebase() {
        FirebaseApp.configure()
    }
    
    private func integrateFirebaseMessaging(for application: UIApplication) {
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { bool, _ in
            Amplitude.instance().logEvent(bool ? AmplitudeEvent.pushNotificationsEnabled : AmplitudeEvent.pushNotificationsDisabled )
        }
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
    }
    
    private func integrateAmplitude() {
        // Enable sending automatic session events
        Amplitude.instance().trackingSessionEvents = true
        // Initialize SDK
        Amplitude.instance().initializeApiKey(Keys.amplitudeApiKey)
        // Log an event
        Amplitude.instance().logEvent(AmplitudeEvent.appStarted)
    }
    
    private func integrateApphud() {
        Apphud.enableDebugLogs()
        Apphud.start(apiKey: Keys.apphudApiKey)
    }
    
    private func integrateAppsFlyer() {
        AppsFlyerLib.shared().appsFlyerDevKey = Keys.appsFlyerDevKey
        AppsFlyerLib.shared().appleAppID = Keys.appleAppId
        
        /* Uncomment the following line to see AppsFlyer debug logs */
        // AppsFlyerLib.shared().isDebug = true
        // Must be called AFTER setting appsFlyerDevKey and appleAppID
        AppsFlyerLib.shared().delegate = self
        
        // SceneDelegate support
        NotificationCenter.default.addObserver(self, selector: NSSelectorFromString("sendLaunch"), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func integrateFacebook(for application: UIApplication, with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        
        Settings.shared.isAdvertiserTrackingEnabled = true
        Settings.shared.isAutoLogAppEventsEnabled = true
        
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "FaceCare")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

// MARK: - AppsFlyerLibDelegate

extension AppDelegate: AppsFlyerLibDelegate {
    
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        Apphud.addAttribution(data: conversionInfo, from: .appsFlyer, identifer: AppsFlyerLib.shared().getAppsFlyerUID()) { _ in
            print("AppsFlyer conversion info sent to Apphud")
        }
    }
    
    func onConversionDataFail(_ error: Error) {
        Apphud.addAttribution(data: ["error" : error.localizedDescription], from: .appsFlyer, identifer: AppsFlyerLib.shared().getAppsFlyerUID()) { _ in }
    }
    
}

// MARK: - UNUserNotificationCenterDelegate

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
                                @escaping (UNNotificationPresentationOptions) -> Void) {
        process(notification)
        if #available(iOS 14.0, *) {
            completionHandler([[.banner, .sound]])
        } else {
            completionHandler([[.alert, .sound]])
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        process(response.notification)
        completionHandler()
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    private func process(_ notification: UNNotification) {
        let userInfo = notification.request.content.userInfo
        Messaging.messaging().appDidReceiveMessage(userInfo)
    }
    
}

// MARK: - MessagingDelegate

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging,
                   didReceiveRegistrationToken fcmToken: String?) {
        let tokenDict = ["token": fcmToken ?? ""]
        
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: tokenDict
        )
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
