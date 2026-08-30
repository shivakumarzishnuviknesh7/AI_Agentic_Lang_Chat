//
//  ChatView.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//

import SwiftUI

struct ChatView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("AI Chat")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Chat with the factory AI agent here.")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Chat")
        }
    }
}

#Preview {
    ChatView()
}
