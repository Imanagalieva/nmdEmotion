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
                .fill(entry.mood.color)
                .frame(width: 12, height: 12)

            VStack(alignment: .leading, spacing: 4) {
                Text(entry.title)
                    .font(.headline)

                Text(entry.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()

            Text("\(entry.intensity)")
                .font(.headline)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }
}
