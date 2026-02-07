//
//  EmotionalDetailView.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct EmotionDetailView: View {

    let entry: EmotionEntry

    var body: some View {
        VStack(spacing: 24) {
            Text(entry.title)
                .font(.largeTitle)
                .bold()

            Text(entry.date.formatted(date: .long, time: .shortened))
                .foregroundColor(.secondary)

            VStack(spacing: 12) {
                Text("Intensity")
                    .font(.headline)

                Text("\(entry.intensity)/10")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(colorForIntensity(entry.intensity))
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func colorForIntensity(_ value: Int) -> Color {
        switch value {
        case 0...3: return .blue
        case 4...6: return .orange
        default: return .red
        }
    }
}

