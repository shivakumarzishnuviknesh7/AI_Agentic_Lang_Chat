//
//  Order.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//



import Foundation

struct Order: Identifiable {
    let id = UUID()

    let orderID: String
    let productName: String
    let customerName: String
    let orderedQuantity: Int
    let availableStock: Int
    let priority: OrderPriority

    var shortageQuantity: Int {
        max(orderedQuantity - availableStock, 0)
    }

    var hasShortage: Bool {
        shortageQuantity > 0
    }
}

enum OrderPriority: String {
    case high = "High"
    case medium = "Medium"
    case normal = "Normal"
}
