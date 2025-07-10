//
//  Task.swift
//  ToDoButCursesEverytimeYouDontFinish
//
//  Created by GradByte
//

import Foundation

struct Task: Identifiable, Codable {
    let id = UUID()
    var name: String
    var isDone: Bool
    
    init(name: String, isDone: Bool = false) {
        self.name = name
        self.isDone = isDone
    }
} 
