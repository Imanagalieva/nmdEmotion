//
//  EmotionFormView.swift
//  emotionalDiaryy
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct EmotionFormView: View {
    
    @EnvironmentObject var viewModel: EmotionDiaryViewModel
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Form State
    @State private var mood: Mood = .happy
    @State private var intensity: Int = 5
    @State private var note: String = ""
    @State private var date: Date = Date()
    @State private var isFavorite: Bool = false
    
    // MARK: - Editing support
    var editingEntry: EmotionEntry? = nil
    
    var body: some View {
        Form {
            
            // MARK: - Mood Picker
            Section(header: Text("Mood")) {
                Picker("Select mood", selection: $mood) {
                    ForEach(Mood.allCases, id: \.self) { mood in
                        Text(mood.title).tag(mood)
                    }
                }
                .pickerStyle(.menu)
            }
            
            // MARK: - Intensity
            Section(header: Text("Intensity")) {
                Stepper(value: $intensity, in: 1...10) {
                    Text("Intensity: \(intensity)")
                }
            }
            
            // MARK: - Note
            Section(header: Text("Note")) {
                TextEditor(text: $note)
                    .frame(height: 120)
            }
            
            // MARK: - Date
            Section(header: Text("Date")) {
                DatePicker(
                    "Select date",
                    selection: $date,
                    displayedComponents: [.date]
                )
            }
            
            // MARK: - Favorite
            Section {
                Toggle("Mark as favorite", isOn: $isFavorite)
            }
            
            // MARK: - Save Button
            Section {
                Button {
                    saveEntry()
                } label: {
                    Text(editingEntry == nil ? "Save Emotion" : "Update Emotion")
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .navigationTitle(editingEntry == nil ? "New Emotion" : "Edit Emotion")
        .onAppear {
            loadEditingData()
        }
    }
    
    // MARK: - Logic
    
    private func loadEditingData() {
        guard let entry = editingEntry else { return }
        mood = entry.mood
        intensity = entry.intensity
        note = entry.note
        date = entry.date
        isFavorite = entry.isFavorite
    }
    
    private func saveEntry() {
        let entry = EmotionEntry(
            id: editingEntry?.id ?? UUID(),
            date: date,
            mood: mood,
            intensity: intensity,
            note: note,
            isFavorite: isFavorite
        )
        
        if editingEntry == nil {
            viewModel.addEntry(entry)
        } else {
            viewModel.updateEntry(entry)
        }
        
        dismiss()
    }
}

