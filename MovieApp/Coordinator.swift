//
//  Coordinator.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/12/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
