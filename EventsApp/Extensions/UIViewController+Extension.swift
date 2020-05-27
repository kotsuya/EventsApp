//
//  UIViewController+Extension.swift
//  EventsApp
//
//  Created by seunghwan.yoo on 2020/05/22.
//  Copyright © 2020 seunghwan.yoo. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiate<T>() -> T {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let controller = storyboard.instantiateViewController(identifier: "\(T.self)") as! T
        return controller
    }
}
