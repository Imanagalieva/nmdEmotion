//
//  EmotionalFormView.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct EmotionFormView: View {

    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: EmotionDiaryViewModel

    @State private var title = ""
    @State private var selectedMood: Mood = .happy
    @State private var intensity: Double = 5
    @State private var date = Date()
    @State private var isImportant = false
    @State private var animate = false

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {

                // MARK: - Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("New Emotion")
                        .font(.largeTitle)
                        .bold()

                    Text("How are you feeling today?")
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                // MARK: - Emotion title
                VStack(alignment: .leading, spacing: 8) {
                    Text("Emotion")
                        .font(.headline)

                    TextField("Happy, Sad, Calm…", text: $title)
                        .padding()
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }

                // MARK: - Mood picker
                VStack(alignment: .leading, spacing: 8) {
                    Text("Mood")
                        .font(.headline)

                    Picker("Mood", selection: $selectedMood) {
                        ForEach(Mood.allCases) { mood in
                            Label(mood.title, systemImage: mood.icon)
                                .tag(mood)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // MARK: - Intensity
                VStack(spacing: 16) {
                    Text("Intensity")
                        .font(.headline)

                    Text("\(Int(intensity))/10")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(intensityColor)
                        .scaleEffect(animate ? 1.1 : 1.0)

                    Slider(value: $intensity, in: 0...10, step: 1)
                        .tint(intensityColor)
                        .onChange(of: intensity) {
                            withAnimation(.spring()) {
                                animate.toggle()
                            }
                        }
                }

                // MARK: - Date
                DatePicker(
                    "Date",
                    selection: $date,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.compact)

                // MARK: - Important
                Toggle("Mark as important", isOn: $isImportant)
                    .tint(.orange)

                // MARK: - Save button
                Button {
                    saveEntry()
                } label: {
                    Text("Save Emotion")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            LinearGradient(
                                colors: [
                                    selectedMood.color,
                                    selectedMood.color.opacity(0.7)
                                ],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .shadow(radius: 8)
                }
                .disabled(title.isEmpty)
                .opacity(title.isEmpty ? 0.4 : 1)
            }
            .padding()
        }
        .navigationTitle("Add Emotion")
        .navigationBarTitleDisplayMode(.inline)
    }

    // MARK: - Helpers

    private var intensityColor: Color {
        switch Int(intensity) {
        case 0...3: return .blue
        case 4...6: return .orange
        default: return .red
        }
    }

    private func saveEntry() {
        let entry = EmotionEntry(
            title: title,
            mood: selectedMood,
            intensity: Int(intensity),
            date: date
        )
        viewModel.addEntry(entry)
        dismiss()
    }
}
