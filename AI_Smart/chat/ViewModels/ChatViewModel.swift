//
//  ChatViewModel.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//
import Foundation
import Combine

@MainActor
final class ChatViewModel: ObservableObject {

    @Published var messages: [ChatMessage] = [
        ChatMessage(
            role: .assistant,
            content: """
            Hello! I am your Factory Inventory AI Agent.

            Ask me about today's orders, stock requirements, or inventory shortages.
            """,
            timestamp: Date()
        )
    ]

    @Published var inputMessage: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let openAIService: OpenAIService

    init(openAIService: OpenAIService) {
        self.openAIService = openAIService
    }

    func sendMessage() async {

        let trimmedMessage = inputMessage
            .trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedMessage.isEmpty else {
            return
        }

        let userMessage = ChatMessage(
            role: .user,
            content: trimmedMessage,
            timestamp: Date()
        )

        messages.append(userMessage)

        inputMessage = ""
        isLoading = true
        errorMessage = nil

        do {

            let response = try await openAIService.sendMessage(
                trimmedMessage
            )

            let assistantMessage = ChatMessage(
                role: .assistant,
                content: response,
                timestamp: Date()
            )

            messages.append(assistantMessage)

        } catch {

            errorMessage = "Unable to contact the AI agent."

            print("Chat error: \(error)")
        }

        isLoading = false
    }
}
