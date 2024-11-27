//
//  TimerManager.swift
//  pausEd
//
//  Created by Don Payton on 11/7/24.
//

import Foundation
import UserNotifications

class TimerManager: ObservableObject {
    @Published var remainingWorkTime: Double = 1500 // 25 minutes
    @Published var workTime: Double = 1500
    @Published var isWorkTimerRunning = false

    @Published var remainingBreakTime: Double = 300 // 5 minutes
    @Published var breakTime: Double = 300
    @Published var isBreakTimerRunning = false

    var workTimer: Timer?
    var breakTimer: Timer?

    // Start Work Timer
    func startWorkTimer() {
        isWorkTimerRunning = true
        workTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.remainingWorkTime > 0 {
                self.remainingWorkTime -= 1
            } else {
                self.workTimer?.invalidate()
                self.isWorkTimerRunning = false
                self.sendNotification(title: "Work Timer Finished", body: "Time to take a break!")
            }
        }
    }

    // Stop Work Timer
    func stopWorkTimer() {
        workTimer?.invalidate()
        isWorkTimerRunning = false
    }

    // Start Break Timer
    func startBreakTimer() {
        isBreakTimerRunning = true
        breakTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.remainingBreakTime > 0 {
                self.remainingBreakTime -= 1
            } else {
                self.breakTimer?.invalidate()
                self.isBreakTimerRunning = false
                self.sendNotification(title: "Break Timer Finished", body: "Time to get back to work!")
            }
        }
    }

    // Stop Break Timer
    func stopBreakTimer() {
        breakTimer?.invalidate()
        isBreakTimerRunning = false
    }

    // Update Work Time
    func updateWorkTime(to newValue: Double) {
        workTime = newValue
        remainingWorkTime = newValue
    }

    // Update Break Time
    func updateBreakTime(to newValue: Double) {
        breakTime = newValue
        remainingBreakTime = newValue
    }

    // Send Notification
    func sendNotification(title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled: \(title)")
            }
        }
    }
    
    func sendTestNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Test Notification"
        content.body = "This is a test notification to verify settings."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        let request = UNNotificationRequest(identifier: "TestNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling test notification: \(error.localizedDescription)")
            } else {
                print("Test notification scheduled.")
            }
        }
    }

}

