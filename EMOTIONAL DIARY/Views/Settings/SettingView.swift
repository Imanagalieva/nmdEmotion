//
//  SettingView.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct SettingView: View {

    @AppStorage("darkMode") private var darkMode = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $darkMode)
                }

                Section(header: Text("About")) {
                    Text("Emotional Diary")
                    Text("Version 1.0")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingView()
}

