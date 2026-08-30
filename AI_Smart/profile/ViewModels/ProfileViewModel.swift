
//
//  ProfileViewModel.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//

import Foundation
import Combine

@MainActor
final class ProfileViewModel: ObservableObject {

    @Published var employee: EmployeeProfile

    init() {
        self.employee = EmployeeProfile(
            name: "Zishnu Viknesh",
            employeeID: "EMP-1024",
            warehouseID: "WH-HAN-01",
            workStatus: .onShift
        )
    }

    func updateWorkStatus(to newStatus: WorkStatus) {
        employee = EmployeeProfile(
            name: employee.name,
            employeeID: employee.employeeID,
            warehouseID: employee.warehouseID,
            workStatus: newStatus
        )
    }
}
