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
                if viewModel.entries.isEmpty {
                    Text("No entries yet 🌱")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(viewModel.entries) { entry in
                        VStack(alignment: .leading, spacing: 6) {
                            Text(entry.title)
                                .font(.headline)

                            Text(entry.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                    .onDelete(perform: viewModel.deleteEntry)
                }
            }
            .navigationTitle("Diary")
        }
    }
}

#Preview {
    DiaryListView()
        .environmentObject(EmotionDiaryViewModel())
}
