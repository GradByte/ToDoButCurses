# ToDoButCurses

## Intro

**ToDoButCurses** is a meme motivational pixel-style todo app that keeps you on track by sending you relentless, curse-filled notifications every minute for any unfinished tasks. The app is designed to be both fun and brutally honest, using rough language and a retro pixel-art UI to push you to get things done.

## Tech Stack

- **Swift**
- **SwiftUI**
- **MVVM Architecture**
- **UserNotifications Framework**
- **Xcode Asset Catalogs** (for icons and colors)

## Features

- **Pixel-Style UI**: Custom-designed, retro-inspired interface with monospaced fonts, square borders, and bold color schemes.
- **Task Management**: Add, complete, and delete tasks with a single tap.
- **Two-Screen Simplicity**: Main screen for viewing/managing tasks, and a dedicated add-task screen.
- **Brutal Motivation**: Every minute, receive a local notification for each unfinished task, each with a randomly chosen, rough curse message.
- **10 Unique Curses**: Each notification features one of ten hand-crafted, explicit motivational curses.
- **Animated Pixel Checkboxes**: Satisfying, animated toggling of task completion.
- **Context Menu**: Long-press on a task to delete it.
- **Custom App Icon**: Pixel-style app icon for a cohesive look.
- **Dark Theme**: Black and red color palette for a bold, retro vibe.
- **Responsive Layout**: Looks great on all iOS devices.

## Learnings

- **SwiftUI Customization**: Building custom UI components and layouts beyond default SwiftUI controls.
- **MVVM Pattern**: Clean separation of business logic and UI using ObservableObject and ViewModel.
- **Local Notifications**: Scheduling, customizing, and handling repeating notifications with UserNotifications.
- **State Management**: Using @StateObject, @ObservedObject, and @Published for reactive UI updates.
- **Asset Management**: Organizing and using custom icons and colors in Xcode asset catalogs.
- **Accessibility & UX**: Creating a visually distinct, accessible, and fun user experience.

## Improvements

- **Persistence**: Add Core Data or SwiftData to save tasks.
- **Custom Notification Sounds**: Use retro or custom sounds for notifications.
- **Settings Screen**: Allow users to toggle curse intensity or notification frequency.
- **Accessibility**: Improve VoiceOver support and color contrast for better accessibility.
- **Testing**: Add unit/UI tests for ViewModel and UI flows.
- **Localization**: Support for multiple languages (and curse styles!).
- **Animations**: Add more pixel-style animations for transitions and interactions.

## Visual

![Demo](demo.gif)
<!-- Or add a YouTube link: https://youtu.be/your-demo-link --> 
