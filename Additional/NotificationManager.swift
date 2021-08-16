//
//  NotificationManager.swift
//  PlantTracker
//
//  Created by Jackson Dowden on 8/15/21.
//

import Foundation
import SwiftUI

class NotificationManager: ObservableObject {
    
    var notifications = [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                //
            } else {
                //
            }
        }
    }
    
    func sendNotification(plant: Plant, title: String, launchIn: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        let launchBig = launchIn * 86400
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: launchBig, repeats: true)
        let request = UNNotificationRequest(identifier: plant.id, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)

    }
    
    func clearNotifications(plant:Plant) {
        let identifier: [String] = [plant.id]
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifier)
    }
    
    func clearAll() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
