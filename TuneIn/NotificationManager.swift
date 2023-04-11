//
//  NotificationManager.swift
//  TuneIn
//
//  Created by Izzy Hood on 4/10/23.
//

import Foundation

import UserNotifications

class NotificationManager {
    
    static func scheduleResetNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Reset didDailyPost property"
        content.body = "The didDailyPost property will be reset for all users."
        content.sound = .default
        
        var dateComponents = DateComponents()
        dateComponents.hour = 0 // 12:00 AM
        dateComponents.minute = 0
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "ResetDidDailyPost", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
}
