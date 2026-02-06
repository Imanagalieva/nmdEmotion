//
//  EmotionEntry.swift
//  emotionalDiaryy
//
//  Created by Zumrad on 07.02.2026.
//
import Foundation

// MARK: - Mood Enum

enum Mood: String, CaseIterable, Codable {
    case happy
    case sad
    case anxious
    case calm
    case angry
    
    // Human-readable title (for UI)
    var title: String {
        switch self {
        case .happy:
            return "Happy"
        case .sad:
            return "Sad"
        case .anxious:
            return "Anxious"
        case .calm:
            return "Calm"
        case .angry:
            return "Angry"
        }
    }
}
// MARK: - EmotionEntry Model

struct EmotionEntry: Identifiable, Codable {
    let id: UUID
    var date: Date
    var mood: Mood
    var intensity: Int
    var note: String
    var isFavorite: Bool
    
    init(
        id: UUID = UUID(),
        date: Date = Date(),
        mood: Mood,
        intensity: Int,
        note: String,
        isFavorite: Bool = false
    ) {
        self.id = id
        self.date = date
        self.mood = mood
        self.intensity = intensity
        self.note = note
        self.isFavorite = isFavorite
    }
}

