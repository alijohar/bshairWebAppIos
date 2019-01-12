//
//  AppDelegate.swift
//  bshairWebAppIos
//
//  Created by johar on 9/16/18.
//  Copyright © 2018 papyrus. All rights reserved.
//

import UIKit
import OneSignal
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{

    var window: UIWindow?

    let myNewsDetail = NewsDetail()
    let myHomePage = ViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // For debugging
        //OneSignal.setLogLevel(.LL_VERBOSE, visualLevel: .LL_NONE)
        
        let notificationReceivedBlock: OSHandleNotificationReceivedBlock = { notification in
            
            print("Received Notification: \(String(describing: notification!.payload.notificationID))")
            print("launchURL = \(notification?.payload.launchURL ?? "None")")
            print("content_available = \(notification?.payload.contentAvailable ?? false)")
        }
        
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            // This block gets called when the user reacts to a notification received
            let payload: OSNotificationPayload? = result?.notification.payload
            
            print("Message = \(String(describing: payload!.body))")
            print("badge number = \(payload?.badge ?? 0)")
            print("notification sound = \(payload?.sound ?? "None")")
            
            if let additionalData = result!.notification.payload!.additionalData {
                print("additionalData = \(additionalData)")
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newsDetailFromPush = mainStoryboard.instantiateViewController(withIdentifier: "News_Detail_push") as! NewsDetailPush
                let HomePage : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "homePageApp") as UIViewController
                self.window = UIWindow(frame: UIScreen.main.bounds)

                
                if additionalData["customKey"] != nil {
                    print(additionalData["customKey"]!)
                    var id:String = additionalData["customKey"] as! String
                    newsDetailFromPush.newsItemId = Int(id)!
                    self.window?.rootViewController = newsDetailFromPush
                    self.window?.makeKeyAndVisible()
                    
//                    TODO NEED SOME WORK TO HANDLE LOADING POST BY ID

                }
                if additionalData["openApp"] != nil {
                    print(additionalData["openApp"]!)
                    self.window?.rootViewController = HomePage
                    self.window?.makeKeyAndVisible()
                    
                }
                if additionalData["openURL"] != nil {
                    print(additionalData["openURL"]!)
                    guard let url = URL(string: additionalData["openURL"]! as! String) else {
                        return //be safe
                    }
                    
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }

                }
                
            }
        }
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: true, ]
        
        OneSignal.initWithLaunchOptions(launchOptions, appId: "2cd9655b-a7da-49fb-83bb-a26ac56e8ade", handleNotificationReceived: notificationReceivedBlock, handleNotificationAction: notificationOpenedBlock, settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification
        

        FirebaseApp.configure()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    
    
}

