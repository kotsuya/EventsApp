//
//  TimeRemainingStackView.swift
//  EventsApp
//
//  Created by seunghwan.yoo on 2020/05/26.
//  Copyright © 2020 seunghwan.yoo. All rights reserved.
//

import UIKit

final class TimeRemainingStackView: UIStackView {
    private let timeRemainingLabels =  [UILabel(),UILabel(),UILabel(),UILabel()]
    
    func setup() {
        timeRemainingLabels.forEach {
            addArrangedSubview($0)
        }
        axis = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func update(with viewModel: TimeRemainingViewModel) {
     
        timeRemainingLabels.forEach {
            $0.text = ""
            $0.font = .systemFont(ofSize: viewModel.fontSize, weight: .medium)
            $0.textColor = .white
        }
        
        viewModel.timeReminingParts.enumerated().forEach {
            timeRemainingLabels[$0.offset].text = $0.element
        }

        alignment = viewModel.alignment
    }

}
