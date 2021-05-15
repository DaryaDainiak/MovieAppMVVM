//
// SceneDelegate.swift
//
//  Created by Дайняк Дарья Станиславовна on 08.03.2021.
//

import UIKit

///
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var coordinator: MainCoordinator?
    var window: UIWindow?
    let coreDataStack = CoreDataStack()

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)

            let navigationController = UINavigationController()

            coordinator = MainCoordinator(navigationController: navigationController)
            coordinator?.start()

            CoreDataService.shared.managedContext = coreDataStack.persistentContainer.viewContext

            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }

        guard (scene as? UIWindowScene) != nil else { return }
    }

    func sceneDidDisconnect(_: UIScene) {}

    func sceneDidBecomeActive(_: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
//        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        coreDataStack.saveContext()
    }
}
