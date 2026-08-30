//
//  ProfileView.swift
//  AI_Smart
//
//  Created by Zishnu Viknesh on 30.08.26.
//
import SwiftUI

struct ProfileView: View {
    
    private let employee = EmployeeProfile(
        name: "Zishnu Viknesh",
        employeeID: "EMP-1024",
        warehouseID: "WH-HAN-01",
        workStatus: .onShift
    )
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    
                    profileHeader
                    
                    employeeInformation
                    
                    workStatusCard
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // MARK: - Profile Header
    
    private var profileHeader: some View {
        VStack(spacing: 12) {
            
            Image(systemName: "person.crop.circle.fill")
                .font(.system(size: 90))
                .foregroundStyle(.blue)
            
            Text(employee.name)
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Warehouse Employee")
                .foregroundStyle(.secondary)
        }
        .padding(.top, 20)
    }
    
    // MARK: - Employee Information
    
    private var employeeInformation: some View {
        VStack(spacing: 14) {
            
            ProfileInfoRow(
                icon: "person.fill",
                title: "Name",
                value: employee.name
            )
            
            ProfileInfoRow(
                icon: "person.text.rectangle",
                title: "Employee ID",
                value: employee.employeeID
            )
            
            ProfileInfoRow(
                icon: "building.2.fill",
                title: "Warehouse ID",
                value: employee.warehouseID
            )
        }
    }
    
    // MARK: - Work Status
    
    private var workStatusCard: some View {
        HStack(spacing: 12) {
            
            Circle()
                .fill(statusColor)
                .frame(width: 12, height: 12)
            
            VStack(alignment: .leading, spacing: 3) {
                
                Text("Work Status")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(employee.workStatus.rawValue)
                    .fontWeight(.semibold)
            }
            
            Spacer()
        }
        .padding()
        .background(
            Color(.secondarySystemBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
    }
    
    // MARK: - Status Color
    
    private var statusColor: Color {
        switch employee.workStatus {
        case .onShift:
            return .green
            
        case .breakTime:
            return .orange
            
        case .offShift:
            return .gray
        }
    }
}


// MARK: - Reusable Profile Row

struct ProfileInfoRow: View {
    
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 16) {
            
            Image(systemName: icon)
                .font(.title3)
                .frame(width: 32)
                .foregroundStyle(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(title)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(value)
                    .font(.body)
                    .fontWeight(.medium)
            }
            
            Spacer()
        }
        .padding()
        .background(
            Color(.secondarySystemBackground)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 16)
        )
    }
}


#Preview {
    ProfileView()
}
