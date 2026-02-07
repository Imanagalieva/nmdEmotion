//
//  EMOTIONAL_DIARYApp.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI 
@main
struct emotionalDiaryyApp: App {

    @StateObject private var viewModel = EmotionDiaryViewModel()

    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(viewModel)
        }
    }
}
