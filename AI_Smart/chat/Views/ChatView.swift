//
//  ChatView.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//

import SwiftUI

struct ChatView: View {
    
    @StateObject private var viewModel: ChatViewModel
    
    init() {
        
        let service = OpenAIService(
            apiKey: "YOUR_API_KEY_TEMPORARILY_HERE"
        )
        
        _viewModel = StateObject(
            wrappedValue: ChatViewModel(
                openAIService: service
            )
        )
    }
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {
                
                messagesView
                
                Divider()
                
                inputArea
            }
            .navigationTitle("Factory AI")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Messages
    
    private var messagesView: some View {
        
        ScrollViewReader { proxy in
            
            ScrollView {
                
                LazyVStack(spacing: 14) {
                    
                    ForEach(viewModel.messages) { message in
                        
                        MessageBubbleView(
                            message: message
                        )
                        .id(message.id)
                    }
                    
                    if viewModel.isLoading {
                        
                        HStack {
                            
                            ProgressView()
                            
                            Text("AI is thinking...")
                                .foregroundStyle(.secondary)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .onChange(of: viewModel.messages.count) {
                
                guard let lastMessage =
                        viewModel.messages.last else {
                    return
                }
                
                withAnimation {
                    
                    proxy.scrollTo(
                        lastMessage.id,
                        anchor: .bottom
                    )
                }
            }
        }
    }
    
    // MARK: - Input
    
    private var inputArea: some View {
        
        VStack(spacing: 6) {
            
            if let error = viewModel.errorMessage {
                
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
            }
            
            HStack(alignment: .bottom) {
                
                TextField(
                    "Ask about inventory...",
                    text: $viewModel.inputMessage,
                    axis: .vertical
                )
                .lineLimit(1...5)
                .padding(12)
                .background(
                    Color(.secondarySystemBackground)
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 18
                    )
                )
                
                Button {
                    
                    Task {
                        await viewModel.sendMessage()
                    }
                    
                } label: {
                    
                    Image(
                        systemName: "arrow.up.circle.fill"
                    )
                    .font(.system(size: 34))
                }
                .disabled(
                    viewModel.inputMessage
                        .trimmingCharacters(
                            in: .whitespacesAndNewlines
                        )
                        .isEmpty ||
                    viewModel.isLoading
                )
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }
}




struct MessageBubbleView: View {
    
    let message: ChatMessage
    
    var isUser: Bool {
        message.role == .user
    }
    
    var body: some View {
        
        HStack {
            
            if isUser {
                Spacer(minLength: 50)
            }
            
            VStack(
                alignment: isUser
                ? .trailing
                : .leading,
                spacing: 5
            ) {
                
                Text(message.content)
                    .padding(12)
                    .background(
                        isUser
                        ? Color.blue
                        : Color(.secondarySystemBackground)
                    )
                    .foregroundStyle(
                        isUser
                        ? Color.white
                        : Color.primary
                    )
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 16
                        )
                    )
                
                Text(
                    message.timestamp,
                    style: .time
                )
                .font(.caption2)
                .foregroundStyle(.secondary)
            }
            
            if !isUser {
                Spacer(minLength: 50)
            }
        }
        .padding(.horizontal)
    }
}
