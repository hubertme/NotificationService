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
                guard isGranted else {
                    // Handle if the user will not grant access
                    print("User denied access!")
                    return
                }
                self.configure()
            }
        }
    }
    
    func configure() {
        UNCenter.delegate = self
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
