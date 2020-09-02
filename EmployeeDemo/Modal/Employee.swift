

import Foundation

// MARK: - EmployeeData
struct EmployeeData: Codable {
    let status: String?
    let data: [Employee]?
}

// MARK: - Employee
struct Employee: Codable {
    let id, employeeName, employeeSalary, employeeAge: String?
    let profileImage: String?

    enum CodingKeys: String, CodingKey {
        case id
        case employeeName = "employee_name"
        case employeeSalary = "employee_salary"
        case employeeAge = "employee_age"
        case profileImage = "profile_image"
    }
}
