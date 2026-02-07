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
    @State private var showAdd = false

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {

                header
                todayHero
                statsGrid
                moodChart
                insightCard
                actionCard
            }
            .padding()
        }
        .sheet(isPresented: $showAdd) {
            NavigationStack {
                EmotionFormView()
                    .environmentObject(viewModel)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.8)) {
                animate = true
            }
        }
    }
}

// MARK: - Header
private extension HomeView {

    var header: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Emotional Diary")
                .font(.largeTitle)
                .bold()

            Text("How are you feeling today?")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .opacity(animate ? 1 : 0)
        .offset(y: animate ? 0 : -20)
    }
}

// MARK: - Today Hero
private extension HomeView {

    var todayHero: some View {
        HStack(spacing: 16) {
            Text(todayEmoji)
                .font(.system(size: 50))

            VStack(alignment: .leading, spacing: 4) {
                Text("Today")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text("Average mood")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text(averageMoodText)
                    .font(.title2)
                    .bold()
            }

            Spacer()
        }
        .padding()
        .background(
            LinearGradient(
                colors: todayGradient,
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.15), radius: 10, y: 5)
        .opacity(animate ? 1 : 0)
        .offset(y: animate ? 0 : 20)
    }

    var averageMoodText: String {
        viewModel.entries.isEmpty
        ? "— / 10"
        : String(format: "%.1f / 10", viewModel.averageMood)
    }

    var todayGradient: [Color] {
        guard !viewModel.entries.isEmpty else {
            return [.gray.opacity(0.4), .gray.opacity(0.6)]
        }

        switch viewModel.averageMood {
        case 0..<4: return [.blue.opacity(0.7), .cyan]
        case 4..<7: return [.orange.opacity(0.8), .yellow]
        default: return [.pink, .purple]
        }
    }

    var todayEmoji: String {
        guard !viewModel.entries.isEmpty else { return "🙂" }

        switch viewModel.averageMood {
        case 0..<4: return "😔"
        case 4..<7: return "😌"
        default: return "😊"
        }
    }
}

// MARK: - Stats Grid
private extension HomeView {

    var statsGrid: some View {
        LazyVGrid(
            columns: [GridItem(.flexible()), GridItem(.flexible())],
            spacing: 16
        ) {
            StatCard(
                title: "Entries",
                value: "\(viewModel.entries.count)",
                icon: "book.fill",
                color: .blue
            )

            StatCard(
                title: "Best Mood",
                value: mostCommonMood,
                icon: "face.smiling.fill",
                color: .pink
            )
        }
        .opacity(animate ? 1 : 0)
        .offset(y: animate ? 0 : 30)
    }

    var mostCommonMood: String {
        guard !viewModel.entries.isEmpty else { return "—" }

        let moods = viewModel.entries.map { $0.mood }
        return moods
            .reduce(into: [:]) { $0[$1, default: 0] += 1 }
            .max { $0.value < $1.value }?
            .key.title ?? "—"
    }
}

// MARK: - Mood Chart
private extension HomeView {

    var moodChart: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Last 7 days")
                .font(.headline)

            HStack(alignment: .bottom, spacing: 8) {
                ForEach(last7Days.indices, id: \.self) { index in
                    Capsule()
                        .fill(Color.accentColor)
                        .frame(
                            width: 12,
                            height: animate
                                ? CGFloat(last7Days[index]) * 10 + 10
                                : 0
                        )
                }
            }
            .frame(height: 110)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 6, y: 4)
    }

    var last7Days: [Int] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        return (0..<7).reversed().map { offset in
            let day = calendar.date(byAdding: .day, value: -offset, to: today)!
            return viewModel.entries
                .filter { calendar.isDate($0.date, inSameDayAs: day) }
                .map { $0.intensity }
                .reduce(0, +)
        }
    }
}

// MARK: - Insight
private extension HomeView {

    var insightCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Insight")
                .font(.headline)

            Text(
                viewModel.entries.isEmpty
                ? "Start logging your emotions to discover patterns 💙"
                : "You tend to feel **\(mostCommonMood.lowercased())** more often. Awareness is the first step to balance 💙"
            )
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 6, y: 4)
    }
}

// MARK: - Action
private extension HomeView {

    var actionCard: some View {
        VStack(spacing: 12) {
            Text("Daily Reminder")
                .font(.headline)

            Text("Log today's emotion to understand yourself better")
                .foregroundColor(.secondary)

            Button {
                showAdd = true
            } label: {
                Label("Add emotion", systemImage: "plus.circle.fill")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: .black.opacity(0.1), radius: 6, y: 4)
    }
}

// MARK: - Stat Card
struct StatCard: View {

    let title: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .padding(10)
                .background(color)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Text(title)
                .foregroundColor(.secondary)

            Text(value)
                .font(.title2)
                .bold()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 6, y: 4)
    }
}
