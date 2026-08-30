//
//  TodayOrdersView.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//

import SwiftUI

struct TodayOrdersView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Today's Orders")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Today's factory orders will appear here.")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Today")
        }
    }
}

#Preview {
    TodayOrdersView()
}
