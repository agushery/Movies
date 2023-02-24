//
//  AppDelegate.swift
//  Movies
//
//  Created by Agus Hery on 23/02/23.
//  Copyright © 2023 Agus Hery. All rights reserved.
//

import Foundation
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted && error == nil {
                print("Notification authorization granted.")
            } else {
                print("Notification authorization denied.")
            }
        }
        
        UNUserNotificationCenter.current().delegate = self
        triggerLocalNotification()
        return true
    }
    
    func triggerLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "New Movie"
        content.body = "Let see ne movie!"
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60*60*12, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
      ) {
        completionHandler([.badge, .badge, .sound])
      }
     
      func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
      ) {
        print("UserInfo yang terkait dengan notifikasi == \(response.notification.request.content.userInfo)")
        completionHandler()
      }
}

