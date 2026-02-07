//
//  DiaryRow.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct DiaryRow: View {

    let entry: EmotionEntry

    var body: some View {
        HStack(spacing: 16) {
            Circle()
                .fill(colorForIntensity(entry.intensity))
                .frame(width: 12, height: 12)

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.title)
                    .font(.headline)

                Text(entry.date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text("\(entry.intensity)/10")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 6)
    }

    private func colorForIntensity(_ value: Int) -> Color {
        switch value {
        case 0...3: return .blue
        case 4...6: return .orange
        default: return .red
        }
    }
}

