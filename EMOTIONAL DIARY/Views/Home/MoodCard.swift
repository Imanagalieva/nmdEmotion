//
//  MoodCard.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct MoodCard: View {

    let title: String
    let value: String
    let systemImage: String
    let gradient: [Color]

    var body: some View {
        HStack(spacing: 16) {

            Image(systemName: systemImage)
                .font(.system(size: 28))
                .foregroundColor(.white)
                .frame(width: 56, height: 56)
                .background(
                    LinearGradient(
                        colors: gradient,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(RoundedRectangle(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(value)
                    .font(.title)
                    .fontWeight(.bold)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.1), radius: 10, y: 6)
        )
    }
}

