//
//  HomeView.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct HomeView: View {

    @EnvironmentObject var viewModel: EmotionDiaryViewModel
    @State private var animate = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // MARK: - Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Emotional Diary")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("Track your emotions and mental state")
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // MARK: - Today Mood Card
                cardView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Today")
                            .font(.headline)
                            .foregroundColor(.secondary)

                        Text(viewModel.entries.last?.mood.title ?? "No data")
                            .font(.title)
                            .fontWeight(.semibold)

                        Text(viewModel.entries.last?.date ?? Date(), style: .date)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                // MARK: - Statistics
                HStack(spacing: 16) {

                    statCard(
                        title: "Entries",
                        value: "\(viewModel.entries.count)"
                    )

                    statCard(
                        title: "Average",
                        value: String(format: "%.1f", viewModel.averageIntensity())
                    )
                }

                Spacer()
            }
            .padding()
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                animate = true
            }
        }
    }

    // MARK: - Card Wrapper
    private func cardView<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        content()
            .padding()
            .frame(maxWidth: .infinity)
            .background(
                LinearGradient(
                    colors: [.blue.opacity(0.25), .purple.opacity(0.25)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .cornerRadius(20)
            .shadow(radius: 10)
            .opacity(animate ? 1 : 0)
            .offset(y: animate ? 0 : 20)
    }

    // MARK: - Stat Card
    private func statCard(title: String, value: String) -> some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 6)
    }
}

