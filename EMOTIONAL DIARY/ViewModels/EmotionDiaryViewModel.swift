//
//  EmotionDiaryViewModel.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import Foundation
import SwiftUI
import Combine

final class EmotionDiaryViewModel: ObservableObject {

    // MARK: - Published properties
    @Published var entries: [EmotionEntry] = []

    // MARK: - Computed properties
    var averageMood: Double {
        guard !entries.isEmpty else { return 5.0 }
        let total = entries.map { $0.intensity }.reduce(0, +)
        return Double(total) / Double(entries.count)
    }

    // MARK: - Init
    init() {
        loadMockData()
    }

    // MARK: - Functions
    func addEntry(_ entry: EmotionEntry) {
        entries.append(entry)
    }

    func deleteEntry(at offsets: IndexSet) {
        entries.remove(atOffsets: offsets)
    }

    // Temporary data (for UI preview & demo)
    private func loadMockData() {
        entries = [
            EmotionEntry(title: "Happy", intensity: 8, date: Date()),
            EmotionEntry(title: "Sad", intensity: 3, date: Date())
        ]
    }
}

