//
//  Identifiers.swift
//  EmployeeDemo
//
//  Created by Ajeet N on 02/09/20.
//  Copyright © 2020 Ajeet N. All rights reserved.
//

import Foundation

class Identifiers: NSObject {
    static let shared = Identifiers()
    
    var employeeCellIdentifier: String {
        return "EmployeeListViewCell"
    }
}
