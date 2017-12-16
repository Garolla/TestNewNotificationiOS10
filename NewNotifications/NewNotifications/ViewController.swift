//
//  ViewController.swift
//  NewNotifications
//
//  Created by Emanuele Garolla on 18/08/2017.
//  Copyright © 2017 Emanuele Garolla. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Request Permissin
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription as Any)
            }
        })
        
    }
    
    @IBAction func NotifyBtnTapped(_ sender: UIButton) {
        scheduleNotifaction(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("Error scheduling notifications")
            }
        })
    }

    func scheduleNotifaction(inSeconds: TimeInterval, completion: @escaping ( _ Success: Bool) -> ()) {
        
        let myImage = "rick_grimes"
        guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none)
        
        
        let notif = UNMutableNotificationContent()
        
        // ONLY FOR EXTENSION
        notif.categoryIdentifier  = "myNotificationCategory"
        
        notif.title = "New Notifcation"
        notif.subtitle = "These are great!"
        notif.body = "The new notification options in iOS 10 are what i've always dreamed of"
        
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error as Any)
                completion(false)
            } else {
                completion(true)
            }
        })
        
    }
}

