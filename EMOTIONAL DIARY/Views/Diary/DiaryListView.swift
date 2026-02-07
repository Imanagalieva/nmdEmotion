//
//  DiaryListView.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI
import Foundation

struct DiaryListView: View {

    @EnvironmentObject var viewModel: EmotionDiaryViewModel
    @State private var showAdd = false

    var body: some View {
        Group {
            if viewModel.entries.isEmpty {
                emptyState
            } else {
                listView
            }
        }
        .navigationTitle("Diary")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showAdd = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
            }
        }
        .sheet(isPresented: $showAdd) {
            NavigationStack {
                EmotionFormView()
                    .environmentObject(viewModel)
            }
        }
    }
}

//
// MARK: - List
//
private extension DiaryListView {

    var listView: some View {
        List {
            ForEach(groupedEntries, id: \.date) { section in
                Section {
                    ForEach(section.entries) { entry in
                        NavigationLink {
                            EmotionalDetailView(entry: entry)
                        } label: {
                            DiaryRow(entry: entry)
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let entry = section.entries[index]
                            viewModel.entries.removeAll { $0.id == entry.id }
                        }
                    }
                } header: {
                    Text(section.date.formatted(date: .long, time: .omitted))
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            }
        }
        .listStyle(.plain)
    }

}

//
// MARK: - Empty State
//
private extension DiaryListView {

    var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "book.closed")
                .font(.system(size: 48))
                .foregroundColor(.secondary)

            Text("No entries yet")
                .font(.title3)
                .fontWeight(.semibold)

            Text("Start tracking your emotions\nto understand yourself better")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)

            Button {
                showAdd = true
            } label: {
                Label("Add First Entry", systemImage: "plus")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

//
// MARK: - Grouping Logic
//
private extension DiaryListView {

    var groupedEntries: [(date: Date, entries: [EmotionEntry])] {
        let grouped = Dictionary(grouping: viewModel.entries) {
            Calendar.current.startOfDay(for: $0.date)
        }

        return grouped
            .map { ($0.key, $0.value.sorted { $0.date > $1.date }) }
            .sorted { $0.date > $1.date }
    }
}

