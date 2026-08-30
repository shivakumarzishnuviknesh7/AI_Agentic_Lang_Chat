
//
//  EmployeeProfile.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//

import Foundation

struct EmployeeProfile {
    
    let name: String
    let employeeID: String
    let warehouseID: String
    let workStatus: WorkStatus
}

enum WorkStatus: String {
    case onShift = "On Shift"
    case breakTime = "On Break"
    case offShift = "Off Shift"
}
