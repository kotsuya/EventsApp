//
//  UIImage+Extension.swift
//  EventsApp
//
//  Created by seunghwan.yoo on 2020/05/26.
//  Copyright © 2020 seunghwan.yoo. All rights reserved.
//

import UIKit

extension UIImage {
    
    func sameAspectRatio(newHeight: CGFloat) -> UIImage {
        let scale = newHeight / size.height
        let newWidth = size.width * scale
        let newSize = CGSize(width: newWidth, height: newHeight)
        return UIGraphicsImageRenderer(size: newSize).image { _ in
            self.draw(in: .init(origin: .zero, size: newSize))
        }
    }
}
