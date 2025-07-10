//
//  ContentView.swift
//  ToDoButCursesEverytimeYouDontFinish
//
//  Created by GradByte
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TaskViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.red.opacity(0.8), Color.black]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    PixelHeaderView()
                    
                    if viewModel.tasks.isEmpty {
                        PixelEmptyStateView()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.tasks) { task in
                                    PixelTaskRowView(task: task, viewModel: viewModel)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                }
                .padding(.top)
            }
            .navigationBarHidden(true)
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        PixelAddButton {
                            viewModel.showingAddTask = true
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 20)
                    }
                }
            )
            .sheet(isPresented: $viewModel.showingAddTask) {
                AddTaskView(viewModel: viewModel)
            }
        }
    }
}

struct PixelHeaderView: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("YOUR TASKS")
                .font(.system(size: 28, weight: .black, design: .monospaced))
                .foregroundColor(.white)
                .shadow(color: .red, radius: 4, x: 2, y: 2)
            
            Text("GET YOUR S*** TOGETHER")
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .foregroundColor(.red)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.red, lineWidth: 2)
                        )
                )
        }
        .padding(.top, 20)
    }
}

struct PixelEmptyStateView: View {
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.red)
                    .frame(width: 80, height: 80)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.white, lineWidth: 3)
                    )
                
                Image(systemName: "list.bullet.clipboard")
                    .font(.system(size: 40, weight: .black))
                    .foregroundColor(.white)
            }
            
            VStack(spacing: 12) {
                Text("NO TASKS YET")
                    .font(.system(size: 24, weight: .black, design: .monospaced))
                    .foregroundColor(.white)
                
                Text("ADD SOME TASKS AND GET YOUR S*** TOGETHER!")
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct PixelTaskRowView: View {
    let task: Task
    @ObservedObject var viewModel: TaskViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.toggleTask(task)
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(task.isDone ? Color.green : Color.clear)
                        .frame(width: 24, height: 24)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(task.isDone ? Color.white : Color.red, lineWidth: 2)
                        )
                    
                    if task.isDone {
                        Text("✓")
                            .font(.system(size: 16, weight: .black))
                            .foregroundColor(.white)
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
            
            Text(task.name)
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                .foregroundColor(task.isDone ? .gray : .white)
                .strikethrough(task.isDone)
                .lineLimit(2)
            
            Spacer()
            
            if !task.isDone {
                ZStack {
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.red)
                        .frame(width: 20, height: 20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.white, lineWidth: 1)
                        )
                    
                    Text("!")
                        .font(.system(size: 12, weight: .black))
                        .foregroundColor(.white)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 0)
                .fill(Color.black.opacity(0.7))
                .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .stroke(task.isDone ? Color.green : Color.red, lineWidth: 2)
                )
        )
        .contextMenu {
            Button("Delete", role: .destructive) {
                viewModel.deleteTask(task)
            }
        }
    }
}

struct PixelAddButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.red)
                    .frame(width: 60, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.white, lineWidth: 3)
                    )
                
                Text("+")
                    .font(.system(size: 32, weight: .black))
                    .foregroundColor(.white)
            }
        }
        .shadow(color: .red, radius: 8, x: 0, y: 4)
    }
}

#Preview {
    ContentView()
}
