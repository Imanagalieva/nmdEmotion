//
//  MainTabView.swift
//  EMOTIONAL DIARY
//
//  Created by Zumrad on 07.02.2026.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            NavigationStack {
                DiaryListView()
            }
            .tabItem {
                Label("Diary", systemImage: "book.fill")
            }

            NavigationStack {
                SettingView()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
    }
}
