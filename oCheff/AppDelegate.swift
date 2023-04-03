//
//  AppDelegate.swift
//  oCheff
//
//  Created by Breno Carvalho Alves De Morais (Bit2B) on 10/02/23.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        registerForPushNotifications()
//        ApplicationDelegate.shared.application(
//            application,
//            didFinishLaunchingWithOptions: launchOptions
//        )
        
        return true
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

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        
//        if let scheme = url.scheme, scheme.localizedCaseInsensitiveCompare("com.bit2b.ocheff") == .orderedSame, let view = url.host {
//
//            var parameters: [String: String] = [:]
//            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
//                parameters[$0.name] = $0.value
//            }
//            
//            //abrir menu
//        }
        
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    func setupRoot() {
        let vc = AppCustomLaunchViewController()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    func setRootNotLoggedUser() {
        let vc = LoginPhoneViewController()
        let nav = UINavigationController(rootViewController: vc)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
    
    func setRootLoggedUser() {
        let tabBarController = TabBarController()
        tabBarController.setupTabBar()
        self.window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
    private func registerForPushNotifications() {
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            // 1. Check to see if permission is granted
            guard granted else { return }
            // 2. Attempt registration for remote notifications on the main thread
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
           print(deviceToken)
       }
       
       func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
           print(error)
       }
}
