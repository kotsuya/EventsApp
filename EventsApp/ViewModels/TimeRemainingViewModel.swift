//
//  TimeRemainingViewModel.swift
//  EventsApp
//
//  Created by seunghwan.yoo on 2020/05/26.
//  Copyright © 2020 seunghwan.yoo. All rights reserved.
//

import UIKit

final class TimeRemainingViewModel {
    
    enum Mode {
        case cell
        case detail
    }
    
    let timeReminingParts: [String]
    private let mode: Mode
    
    var fontSize: CGFloat {
        switch mode {
        case .cell:
            return 25
        case .detail:
            return 60
        }
    }
    
    var alignment: UIStackView.Alignment {
        switch mode {
        case .cell:
            return .trailing
        case .detail:
            return .center
        }
    }
    
    init(timeReminingParts: [String], mode: Mode) {
        self.timeReminingParts = timeReminingParts
        self.mode = mode
    }
}
