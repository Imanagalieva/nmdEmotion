//
//  EmotionalEntry.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import Foundation



struct EmotionEntry: Identifiable {
    let id = UUID()
    let title: String
    let mood: Mood
    let intensity: Int
    let date: Date
}
