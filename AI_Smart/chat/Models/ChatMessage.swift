//
//  ChatMessage.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//

import Foundation

struct ChatMessage: Identifiable, Equatable {
    let id = UUID()
    let role: MessageRole
    let content: String
    let timestamp: Date
}

enum MessageRole {
    case user
    case assistant
}
