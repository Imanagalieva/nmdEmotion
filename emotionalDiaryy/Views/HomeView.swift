//
//  HomeView.swift
//  emotionalDiaryy
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: EmotionDiaryViewModel
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Welcome to Emotional Diary")
                .font(.title)
            
            Text("Average mood intensity:")
            
            Text(String(format: "%.1f", viewModel.averageIntensity()))
                .font(.largeTitle)
                .bold()
        }
        .padding()
    }
}

