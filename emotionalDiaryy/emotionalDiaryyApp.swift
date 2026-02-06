//
//  emotionalDiaryyApp.swift
//  emotionalDiaryy
//
//  Created by Zumrad on 07.02.2026.
//

import SwiftUI

@main
struct EmotionalDiaryApp: App {
    
    @StateObject private var viewModel = EmotionDiaryViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(viewModel)
        }
    }
}
