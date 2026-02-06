//
//  EmotionDiaryViewModel.swift
//  emotionalDiaryy
//
//  Created by Zumrad on 07.02.2026.
//
import Foundation
import Combine
import SwiftUI


final class EmotionDiaryViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var entries: [EmotionEntry] = []
    
    // MARK: - Initializer
    
    init() {
        loadEntries()
    }
    
    // MARK: - CRUD Operations
    
    func addEntry(_ entry: EmotionEntry) {
        withAnimation {
            entries.append(entry)
            sortEntries()
        }
        saveEntries()
    }

    func deleteEntry(at offsets: IndexSet) {
        withAnimation {
            entries.remove(atOffsets: offsets)
        }
        saveEntries()
    }


    
    func updateEntry(_ entry: EmotionEntry) {
        guard let index = entries.firstIndex(where: { $0.id == entry.id }) else {
            return
        }
        entries[index] = entry
        sortEntries()
        saveEntries()
    }
    
    // MARK: - Helpers (Logic & Closures)
    
    func sortEntries() {
        entries = entries.sorted { $0.date > $1.date }
    }
    
    func averageIntensity() -> Double {
        guard !entries.isEmpty else { return 0 }
        let total = entries.map { $0.intensity }.reduce(0, +)
        return Double(total) / Double(entries.count)
    }
    
    func mostFrequentMood() -> Mood? {
        let moods = entries.map { $0.mood }
        let counts = Dictionary(grouping: moods, by: { $0 })
            .mapValues { $0.count }
        
        return counts.max(by: { $0.value < $1.value })?.key
    }
    
    // MARK: - Persistence (UserDefaults)
    
    private let storageKey = "emotion_entries"
    
    private func saveEntries() {
        do {
            let data = try JSONEncoder().encode(entries)
            UserDefaults.standard.set(data, forKey: storageKey)
        } catch {
            print("Failed to save entries:", error)
        }
    }
    
    private func loadEntries() {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            return
        }
        
        do {
            entries = try JSONDecoder().decode([EmotionEntry].self, from: data)
            sortEntries()
        } catch {
            print("Failed to load entries:", error)
        }
    }
}

