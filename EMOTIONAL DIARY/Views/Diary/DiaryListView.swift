//
//  DiaryListView.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct DiaryListView: View {

    @EnvironmentObject var viewModel: EmotionDiaryViewModel

    var body: some View {
        NavigationStack {
            List {
                // Today section
                if !todayEntries.isEmpty {
                    Section("Today") {
                        ForEach(todayEntries) { entry in
                            NavigationLink {
                                EmotionDetailView(entry: entry)
                            } label: {
                                DiaryRow(entry: entry)
                            }
                        }
                        .onDelete(perform: viewModel.deleteEntry)
                    }
                }

                // Earlier section
                if !earlierEntries.isEmpty {
                    Section("Earlier") {
                        ForEach(earlierEntries) { entry in
                            NavigationLink {
                                EmotionDetailView(entry: entry)
                            } label: {
                                DiaryRow(entry: entry)
                            }
                        }
                        .onDelete(perform: viewModel.deleteEntry)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Diary")
        }
    }

    // MARK: - Helpers

    private var todayEntries: [EmotionEntry] {
        viewModel.entries.filter {
            Calendar.current.isDateInToday($0.date)
        }
    }

    private var earlierEntries: [EmotionEntry] {
        viewModel.entries.filter {
            !Calendar.current.isDateInToday($0.date)
        }
    }
}
