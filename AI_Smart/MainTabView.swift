//
//  MainTabView.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {

            ChatView()
                .tabItem {
                    Label("Chat", systemImage: "message.fill")
                }

            TodayOrdersView()
                .tabItem {
                    Label("Today", systemImage: "list.bullet.clipboard.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
    }
}

#Preview {
    MainTabView()
}
