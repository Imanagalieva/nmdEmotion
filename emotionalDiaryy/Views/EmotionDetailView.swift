//
//  EmotionDetailView.swift
//  emotionalDiaryy
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct EmotionDetailView: View {
    
    let entry: EmotionEntry
    
    @EnvironmentObject var viewModel: EmotionDiaryViewModel
    @State private var showEditForm = false
    
    var body: some View {
        VStack(spacing: 16) {
            Text(entry.mood.title)
                .font(.largeTitle)
            
            Text("Intensity: \(entry.intensity)")
                .font(.headline)
            
            if entry.isFavorite {
                Label("Favorite", systemImage: "star.fill")
                    .foregroundColor(.yellow)
                    .transition(.scale)
            }

            
            Text(entry.note)
                .padding()
            
            Text(entry.date, style: .date)
                .foregroundColor(.secondary)
        }
        .padding()
        .navigationTitle("Details")
        .toolbar {
            Button("Edit") {
                showEditForm = true
            }
        }
        .sheet(isPresented: $showEditForm) {
            NavigationStack {
                EmotionFormView(editingEntry: entry)
                    .environmentObject(viewModel)
            }
        }
    }
}
