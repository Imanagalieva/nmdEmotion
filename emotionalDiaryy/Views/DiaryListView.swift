//
//  DiaryListView.swift
//  emotionalDiaryy
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct DiaryListView: View {
    
    @EnvironmentObject var viewModel: EmotionDiaryViewModel
    
    var body: some View {
        NavigationStack {
            List {
                if viewModel.entries.isEmpty {
                    Text("No entries yet. Add your first emotion 🌱")
                        .foregroundColor(.gray)
                } else {
                    ForEach(viewModel.entries) { entry in
                        NavigationLink {
                            EmotionDetailView(entry: entry)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(entry.mood.title)
                                    .font(.headline)
                                
                                Text(entry.note)
                                    .font(.subheadline)
                                    .lineLimit(1)
                                
                                Text(entry.date, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .onDelete(perform: viewModel.deleteEntry)
                }
            }
            .navigationTitle("Diary")
            .toolbar {
                NavigationLink {
                    EmotionFormView()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

