//
//  ProfileView.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 90))

                Text("Factory User")
                    .font(.title)
                    .fontWeight(.bold)

                Text("Inventory Operator")
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
