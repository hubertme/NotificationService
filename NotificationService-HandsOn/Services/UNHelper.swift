//
//  UNHelper.swift
//  NotificationService-HandsOn
//
//  Created by Hubert Wang on 20/12/2018.
//  Copyright © 2018 Hubert Wang. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class UNHelper: NSObject {
    
    private override init() {}
    static let shared = UNHelper()
    
    let UNCenter = UNUserNotificationCenter.current()
    
    func authorize() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound, .carPlay]
        UNCenter.requestAuthorization(options: options) { (isGranted, error) in
            if let error = error {
                print("Error in authorising:", error.localizedDescription)
            }
            guard isGranted else {
                // Handle if the user will not grant access
                print("User denied access!")
                return
            }
            self.configure()
        }
    }
    
    func configure() {
        UNCenter.delegate = self
    }
    
    // MARK: - Methods to notify users in constraint
    func timerRequest(with interval: TimeInterval) {
        let content = UNMutableNotificationContent()
        content.title = "Timer finished"
        content.body = "Your timer is up"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.timer",
                                            content: content,
                                            trigger: trigger)
        UNCenter.add(request) { (error) in
            if error != nil {
                print("Error in adding local timer notification")
            }
        }
    }
    
    func dateRequest(with components: DateComponents){
        let content = UNMutableNotificationContent()
        content.title = "Date triggered!"
        content.body = "It is the future!"
        content.sound = .default
        content.badge = 2
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "userNotification.date", content: content, trigger: trigger)
        
        UNCenter.add(request) { (error) in
            if error != nil {
                print("Error in adding local date notification")
            }
        }
    }
    
    func locationRequest(){
        let content = UNMutableNotificationContent()
        content.title = "You have returned"
        content.body = "おかえりなさい!"
        content.sound = .default
        content.badge = 3
        
        let request = UNNotificationRequest(identifier: "userNotification.location", content: content, trigger: nil)
        
        UNCenter.add(request) { (error) in
            if error != nil {
                print("Error in adding local location notification")
            }
        }
    }
}

// MARK: -
extension UNHelper: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("UN did receive response")
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("UN will present")
        
        let options: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(options)
    }
}
