//
//  OrdersViewModel.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//



import Foundation
import Combine

@MainActor
final class OrdersViewModel: ObservableObject {

    @Published var orders: [Order] = []

    init() {
        loadSampleOrders()
    }

    var totalOrders: Int {
        orders.count
    }

    var totalUnitsOrdered: Int {
        orders.reduce(0) {
            $0 + $1.orderedQuantity
        }
    }

    var shortageCount: Int {
        orders.filter {
            $0.hasShortage
        }.count
    }

    var totalShortageQuantity: Int {
        orders.reduce(0) {
            $0 + $1.shortageQuantity
        }
    }

    private func loadSampleOrders() {

        orders = [

            Order(
                orderID: "ORD-1001",
                productName: "Product A",
                customerName: "Customer Alpha",
                orderedQuantity: 100,
                availableStock: 120,
                priority: .normal
            ),

            Order(
                orderID: "ORD-1002",
                productName: "Product B",
                customerName: "Customer Beta",
                orderedQuantity: 50,
                availableStock: 20,
                priority: .high
            ),

            Order(
                orderID: "ORD-1003",
                productName: "Product C",
                customerName: "Customer Gamma",
                orderedQuantity: 80,
                availableStock: 100,
                priority: .medium
            ),

            Order(
                orderID: "ORD-1004",
                productName: "Product D",
                customerName: "Customer Delta",
                orderedQuantity: 75,
                availableStock: 40,
                priority: .high
            )
        ]
    }
}
