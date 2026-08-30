//
//  TodayOrdersView.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//



import SwiftUI

struct TodayOrdersView: View {

    @StateObject private var viewModel = OrdersViewModel()

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack(
                    alignment: .leading,
                    spacing: 20
                ) {

                    summarySection

                    ordersSection
                }
                .padding()
            }
            .navigationTitle("Today's Orders")
        }
    }

    // MARK: - Summary

    private var summarySection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Daily Summary")
                .font(.headline)

            HStack(spacing: 12) {

                SummaryCard(
                    title: "Orders",
                    value: "\(viewModel.totalOrders)",
                    icon: "shippingbox.fill"
                )

                SummaryCard(
                    title: "Units",
                    value: "\(viewModel.totalUnitsOrdered)",
                    icon: "cube.box.fill"
                )
            }

            HStack(spacing: 12) {

                SummaryCard(
                    title: "Shortages",
                    value: "\(viewModel.shortageCount)",
                    icon: "exclamationmark.triangle.fill"
                )

                SummaryCard(
                    title: "Units Needed",
                    value: "\(viewModel.totalShortageQuantity)",
                    icon: "arrow.down.circle.fill"
                )
            }
        }
    }

    // MARK: - Orders

    private var ordersSection: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            Text("Orders")
                .font(.headline)

            ForEach(viewModel.orders) { order in

                OrderCardView(
                    order: order
                )
            }
        }
    }
}


// MARK: - Summary Card

struct SummaryCard: View {

    let title: String
    let value: String
    let icon: String

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 10
        ) {

            Image(systemName: icon)
                .font(.title2)

            Text(value)
                .font(.title2)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding()
        .background(
            Color(.secondarySystemBackground)
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 16
            )
        )
    }
}


// MARK: - Order Card

struct OrderCardView: View {

    let order: Order

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 12
        ) {

            HStack {

                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {

                    Text(order.productName)
                        .font(.headline)

                    Text(order.orderID)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text(order.priority.rawValue)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(
                        priorityColor.opacity(0.15)
                    )
                    .foregroundStyle(
                        priorityColor
                    )
                    .clipShape(
                        Capsule()
                    )
            }

            Divider()

            OrderInfoRow(
                title: "Customer",
                value: order.customerName
            )

            OrderInfoRow(
                title: "Ordered",
                value: "\(order.orderedQuantity)"
            )

            OrderInfoRow(
                title: "Available",
                value: "\(order.availableStock)"
            )

            if order.hasShortage {

                HStack(spacing: 8) {

                    Image(
                        systemName:
                            "exclamationmark.triangle.fill"
                    )

                    Text(
                        "Need \(order.shortageQuantity) more units"
                    )
                    .fontWeight(.semibold)
                }
                .foregroundStyle(.red)

            } else {

                HStack(spacing: 8) {

                    Image(
                        systemName:
                            "checkmark.circle.fill"
                    )

                    Text("Stock available")
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.green)
            }
        }
        .padding()
        .background(
            Color(.secondarySystemBackground)
        )
        .clipShape(
            RoundedRectangle(
                cornerRadius: 16
            )
        )
    }

    private var priorityColor: Color {

        switch order.priority {

        case .high:
            return .red

        case .medium:
            return .orange

        case .normal:
            return .blue
        }
    }
}


// MARK: - Order Info Row

struct OrderInfoRow: View {

    let title: String
    let value: String

    var body: some View {

        HStack {

            Text(title)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.medium)
        }
    }
}


#Preview {
    TodayOrdersView()
}
