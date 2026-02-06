//
//  MainTabView.swift
//  emotionalDiaryy
//
//  Created by Zumrad on 07.02.2026.
//
import SwiftUI

struct MainTabView: View {
    
    var body: some View {
        TabView {
            
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            DiaryListView()
                .tabItem {
                    Label("Diary", systemImage: "book")
                }
        }
    }
}

