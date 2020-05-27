//
//  Data+Extension.swift
//  EventsApp
//
//  Created by seunghwan.yoo on 2020/05/26.
//  Copyright © 2020 seunghwan.yoo. All rights reserved.
//

import Foundation

extension Date {
    
    func timeRemaining(until endDate: Date) -> String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month, .weekOfMonth, .day]
        dateComponentsFormatter.unitsStyle = .full
        return dateComponentsFormatter.string(from: self, to: endDate)
    }
}
