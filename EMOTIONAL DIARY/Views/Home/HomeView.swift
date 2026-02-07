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

                    Text("How are you feeling today?")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(animate ? 1 : 0)
                .offset(y: animate ? 0 : -20)

                // MARK: - Today Mood Card
                MoodCard(
                    title: "Average Mood",
                    value: String(format: "%.1f", viewModel.averageMood),
                    systemImage: "heart.fill",
                    gradient: [.pink, .purple]
                )

                // MARK: - Entries Count Card
                MoodCard(
                    title: "Total Entries",
                    value: "\(viewModel.entries.count)",
                    systemImage: "book.fill",
                    gradient: [.blue, .cyan]
                )

                // MARK: - Motivation Card
                VStack(alignment: .leading, spacing: 12) {
                    Text("Daily Reminder")
                        .font(.headline)

                    Text("Tracking emotions helps you understand yourself better 💙")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
                )
                .opacity(animate ? 1 : 0)
                .offset(y: animate ? 0 : 30)

            }
            .padding()
        }
        .onAppear {
            withAnimation(.easeOut(duration: 0.8)) {
                animate = true
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(EmotionDiaryViewModel())
}

