//
//  OpenAIService.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//

import Foundation

final class OpenAIService {
    
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func sendMessage(_ message: String) async throws -> String {
        
        guard let url = URL(
            string: "https://api.openai.com/v1/responses"
        ) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        request.setValue(
            "Bearer \(apiKey)",
            forHTTPHeaderField: "Authorization"
        )
        
        let body = OpenAIRequest(
            model: "gpt-5.6-luna",
            input: message
        )
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, response) = try await URLSession.shared.data(
            for: request
        )
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            
            if let errorText = String(
                data: data,
                encoding: .utf8
            ) {
                print("OpenAI Error: \(errorText)")
            }
            
            throw URLError(.badServerResponse)
        }
        
        let decodedResponse = try JSONDecoder().decode(
            OpenAIResponse.self,
            from: data
        )
        
        guard
            let output = decodedResponse.output.first,
            let content = output.content.first,
            let text = content.text
        else {
            throw URLError(.cannotParseResponse)
        }
        
        return text
    }
}






private struct OpenAIRequest: Codable {
    let model: String
    let input: String
}

private struct OpenAIResponse: Codable {
    let output: [OpenAIOutput]
}

private struct OpenAIOutput: Codable {
    let content: [OpenAIContent]
}

private struct OpenAIContent: Codable {
    let text: String?
}
