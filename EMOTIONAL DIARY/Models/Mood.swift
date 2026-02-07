//
//  Mood.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

enum Mood: String, CaseIterable, Identifiable, Hashable {
    case happy
    case calm
    case neutral
    case sad
    case angry

    var id: String { rawValue }

    var title: String {
        rawValue.capitalized
    }

    var color: Color {
        switch self {
        case .happy: return .pink
        case .calm: return .blue
        case .neutral: return .gray
        case .sad: return .indigo
        case .angry: return .red
        }
    }

    var icon: String {
        switch self {
        case .happy: return "face.smiling"
        case .calm: return "leaf"
        case .neutral: return "minus.circle"
        case .sad: return "cloud.rain"
        case .angry: return "flame"
        }
    }
}

