//
//  Coordinator.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/12/21.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get }

    func start()
}
