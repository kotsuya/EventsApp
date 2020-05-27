//
//  ImagePickerCoordinator.swift
//  EventsApp
//
//  Created by seunghwan.yoo on 2020/05/22.
//  Copyright © 2020 seunghwan.yoo. All rights reserved.
//

import UIKit

final class ImagePickerCoordinator: NSObject, Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    var parentCoordinator: AddEventCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        navigationController.present(imagePickerController, animated: true, completion: nil)
    }
}

extension ImagePickerCoordinator: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            parentCoordinator?.didFinishPicking(image)
        }
        parentCoordinator?.childDidFinish(self)
    }
}
