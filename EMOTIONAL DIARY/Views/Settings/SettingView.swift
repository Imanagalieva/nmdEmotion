//
//  SettingView.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct SettingView: View {

    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @AppStorage("dailyReminder") private var dailyReminder = true

    var body: some View {
        NavigationStack {
            Form {

                // MARK: - Appearance
                Section(header: Text("Appearance")) {
                    Toggle(isOn: $darkModeEnabled) {
                        Label("Dark Mode", systemImage: "moon.fill")
                    }
                }

                // MARK: - Notifications
                Section(header: Text("Reminders")) {
                    Toggle(isOn: $dailyReminder) {
                        Label("Daily Mood Reminder", systemImage: "bell.fill")
                    }
                }

                // MARK: - About
                Section {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0")
                            .foregroundColor(.secondary)
                    }

                    HStack {
                        Text("Developer")
                        Spacer()
                        Text("Zumrad")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .preferredColorScheme(darkModeEnabled ? .dark : .light)
    }
}

