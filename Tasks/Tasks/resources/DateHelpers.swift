//
//  DateHelpers.swift
//  Tasks
//
//  Created by Ian Hall on 8/7/19.
//  Copyright © 2019 Ian Hall. All rights reserved.
//

import Foundation

extension Date {
    func stringValue() -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: self)
    }
}
