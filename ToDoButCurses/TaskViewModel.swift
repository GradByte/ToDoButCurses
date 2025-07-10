//
//  TaskViewModel.swift
//  ToDoButCursesEverytimeYouDontFinish
//
//  Created by GradByte
//

import Foundation
import UserNotifications
import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    @Published var showingAddTask = false
    
    private let curses = [
        "Get your lazy a** up and finish '\(0)' you worthless piece of s***!",
        "You're still not done with '\(0)'? What the f*** is wrong with you?",
        "Stop being such a pathetic loser and complete '\(0)' already!",
        "Are you kidding me? '\(0)' is still not done? You're f***ing useless!",
        "Get off your a** and finish '\(0)' you lazy b******!",
        "What the h*** are you waiting for? Complete '\(0)' now you piece of s***!",
        "You call yourself productive? '\(0)' is still pending you d******!",
        "Stop procrastinating and finish '\(0)' you worthless waste of space!",
        "Get your s*** together and complete '\(0)' you lazy f***!",
        "Are you really this incompetent? '\(0)' is still not done you m****!"
    ]
    
    init() {
        requestNotificationPermission()
        scheduleNotifications()
    }
    
    func addTask(_ name: String) {
        let task = Task(name: name)
        tasks.append(task)
        scheduleNotifications()
    }
    
    func toggleTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isDone.toggle()
            scheduleNotifications()
        }
    }
    
    func deleteTask(_ task: Task) {
        tasks.removeAll { $0.id == task.id }
        scheduleNotifications()
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification permission granted")
            } else {
                print("Notification permission denied")
            }
        }
    }
    
    private func scheduleNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let undoneTasks = tasks.filter { !$0.isDone }
        
        for task in undoneTasks {
            scheduleNotificationForTask(task)
        }
    }
    
    private func scheduleNotificationForTask(_ task: Task) {
        let content = UNMutableNotificationContent()
        content.title = "Get Your S*** Together!"
        
        let randomCurse = curses.randomElement() ?? curses[0]
        content.body = randomCurse.replacingOccurrences(of: "\(0)", with: task.name)
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: "task-\(task.id.uuidString)",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
} 
