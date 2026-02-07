//
//  EmotionalDetailView.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct EmotionalDetailView: View {

    let entry: EmotionEntry

    var body: some View {
        VStack(spacing: 24) {

            Image(systemName: entry.mood.icon)
                .font(.system(size: 64))
                .foregroundColor(entry.mood.color)

            Text(entry.title)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(entry.date.formatted(date: .long, time: .shortened))
                .foregroundColor(.secondary)

            Text("Intensity: \(entry.intensity)")
                .font(.title2)

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
    }
}

