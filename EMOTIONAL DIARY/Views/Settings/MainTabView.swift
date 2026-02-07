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
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            DiaryListView()
                .tabItem {
                    Label("Diary", systemImage: "book.fill")
                }

            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .navigationBarItems(trailing:
                    NavigationLink {
                        EmotionFormView()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                )
            TabView {

                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }

                DiaryListView()
                    .tabItem {
                        Label("Diary", systemImage: "book.fill")
                    }

                SettingView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }


        }
    }
}
