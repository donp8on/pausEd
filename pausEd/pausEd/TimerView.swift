//
//  TimerView.swift
//  pausEd
//
//  Created by Don Payton on 10/29/24.
//

import SwiftUI
import UserNotifications

struct TimerView: View {
    @ObservedObject var timerManager: TimerManager

    @State private var workTime: Double = 25
        @State private var breakTime: Double = 5
        @State private var workTimeRemaining: Double = 25 * 60
        @State private var breakTimeRemaining: Double = 5 * 60
        @State private var isWorkTimerRunning = false
        @State private var isBreakTimerRunning = false

        var body: some View {
            VStack(spacing: 30) {
                // Work Timer
                TimerCard(
                    title: "Work Timer",
                    time: $workTime,
                    timeRemaining: $workTimeRemaining,
                    isRunning: $isWorkTimerRunning,
                    color: Color.blue
                )
                
                Divider()
                    .padding(.horizontal, 40)

                // Break Timer
                TimerCard(
                    title: "Break Timer",
                    time: $breakTime,
                    timeRemaining: $breakTimeRemaining,
                    isRunning: $isBreakTimerRunning,
                    color: Color.green
                )
            }
            .padding()
            .background(Color(UIColor.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }

struct TimerCard: View {
    let title: String
    @Binding var time: Double
    @Binding var timeRemaining: Double
    @Binding var isRunning: Bool
    let color: Color
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 15) {
            Text(title)
                .font(.headline)
                .foregroundColor(color)

            ZStack {
                Circle()
                    .stroke(color.opacity(0.3), lineWidth: 10)
                Circle()
                    .trim(from: 0, to: CGFloat(timeRemaining / (time * 60)))
                    .stroke(color, lineWidth: 10)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut, value: timeRemaining)

                Text(formatTime(timeRemaining))
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(color)
            }
            .frame(width: 150, height: 150)

            Slider(
                value: $time,
                in: 1...60,
                step: 1,
                onEditingChanged: { _ in
                    resetTimer()
                }
            ) {
                Text("Adjust \(title)")
            }
            .accentColor(color)
            .padding(.horizontal)

            HStack(spacing: 20) {
                Button(action: {
                    isRunning.toggle()
                    if isRunning {
                        startTimer()
                    } else {
                        stopTimer()
                    }
                }) {
                    HStack {
                        Image(systemName: isRunning ? "pause.circle" : "play.circle")
                        Text(isRunning ? "Pause" : "Start")
                    }
                }
                .buttonStyle(FilledButtonStyle(color: color))
                
                Button(action: {
                    resetTimer()
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise.circle")
                        Text("Reset")
                    }
                }
                .buttonStyle(FilledButtonStyle(color: color.opacity(0.8)))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 5)
    }

    func startTimer() {
        stopTimer()
        scheduleNotification(title: title, seconds: timeRemaining) // Schedule notification
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }

    func resetTimer() {
        stopTimer()
        timeRemaining = time * 60
        isRunning = false
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests() // Cancel notifications
    }

    func scheduleNotification(title: String, seconds: Double) {
        let content = UNMutableNotificationContent()
        content.title = "\(title) Complete!"
        content.body = "Your \(title.lowercased()) has finished."
        content.sound = .default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }

    func formatTime(_ seconds: Double) -> String {
        let minutes = Int(seconds) / 60
        let seconds = Int(seconds) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}


    struct FilledButtonStyle: ButtonStyle {
        let color: Color

        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.system(size: 18, weight: .medium))
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(color: color.opacity(0.4), radius: configuration.isPressed ? 2 : 5, x: 0, y: configuration.isPressed ? 1 : 3)
        }
    }

    
