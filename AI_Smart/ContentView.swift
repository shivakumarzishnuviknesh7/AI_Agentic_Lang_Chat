//
//  ContentView.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 23.08.26.
//

import SwiftUI

struct LoginView: View {
    
    @State private var userID: String = ""
    @State private var passcode: String = ""
    @State private var showPassword: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                
                Spacer()
                
                // MARK: - Title
                
                VStack(spacing: 8) {
                    Image(systemName: "brain.head.profile")
                        .font(.system(size: 60))
                    
                    Text("AI Agent")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Sign in to continue")
                        .foregroundStyle(.secondary)
                }
                
                // MARK: - User ID
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("User ID")
                        .font(.headline)
                    
                    TextField("Enter your User ID", text: $userID)
                        .textFieldStyle(.roundedBorder)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
                
                // MARK: - Passcode
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Passcode")
                        .font(.headline)
                    
                    HStack {
                        if showPassword {
                            TextField("Enter your passcode", text: $passcode)
                        } else {
                            SecureField("Enter your passcode", text: $passcode)
                        }
                        
                        Button {
                            showPassword.toggle()
                        } label: {
                            Image(
                                systemName: showPassword
                                ? "eye.slash"
                                : "eye"
                            )
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.4))
                    )
                }
                
                // MARK: - Error
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundStyle(.red)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                // MARK: - Login
                
                Button {
                    login()
                } label: {
                    Text("Login")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.borderedProminent)
                .disabled(userID.isEmpty || passcode.isEmpty)
                
                Spacer()
            }
            .padding(24)
        }
    }
    
    private func login() {
        errorMessage = ""
        
        guard !userID.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please enter your User ID."
            return
        }
        
        guard !passcode.isEmpty else {
            errorMessage = "Please enter your passcode."
            return
        }
        
        // Temporary authentication for development only.
        if userID == "admin" && passcode == "1234" {
            print("Login successful")
        } else {
            errorMessage = "Invalid User ID or passcode."
        }
    }
}

#Preview {
    LoginView()
}
