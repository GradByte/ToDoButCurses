//
//  AddTaskView.swift
//  ToDoButCursesEverytimeYouDontFinish
//
//  Created by GradByte
//

import SwiftUI

struct AddTaskView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var taskName = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color.red.opacity(0.8), Color.black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 30) {
                PixelAddHeaderView()
                
                VStack(spacing: 24) {
                    PixelTextField(text: $taskName, placeholder: "ENTER TASK NAME")
                    
                    Text("WHAT DO YOU NEED TO GET DONE, YOU LAZY BAS****?")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 0)
                                .fill(Color.black.opacity(0.7))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 0)
                                        .stroke(Color.red, lineWidth: 2)
                                )
                        )
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    PixelButton(
                        title: "CANCEL (U'RE WEAK)",
                        color: .gray,
                        action: { dismiss() }
                    )
                    
                    PixelButton(
                        title: "ADD TASK",
                        color: taskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? .gray : .red,
                        action: {
                            if !taskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                                viewModel.addTask(taskName.trimmingCharacters(in: .whitespacesAndNewlines))
                                dismiss()
                            }
                        }
                    )
                    .disabled(taskName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 40)
        }
        .navigationBarHidden(true)
    }
}

struct PixelAddHeaderView: View {
    var body: some View {
        VStack(spacing: 12) {
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
            
            Text("ADD NEW TASK")
                .font(.system(size: 24, weight: .black, design: .monospaced))
                .foregroundColor(.white)
                .shadow(color: .red, radius: 4, x: 2, y: 2)
        }
    }
}

struct PixelTextField: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
                .font(.system(size: 12, weight: .bold, design: .monospaced))
                .foregroundColor(.red)
            
            TextField("", text: $text)
                .font(.system(size: 16, weight: .medium, design: .monospaced))
                .foregroundColor(.white)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.black.opacity(0.7))
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.red, lineWidth: 2)
                        )
                )
                .textFieldStyle(PlainTextFieldStyle())
        }
    }
}

struct PixelButton: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .black, design: .monospaced))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 0)
                        .fill(color)
                        .overlay(
                            RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.white, lineWidth: 2)
                        )
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AddTaskView(viewModel: TaskViewModel())
} 
