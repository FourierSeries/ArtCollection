//
//  TabBarController.swift
//  ArtCollection
//
//  Created by Динар Хайруллин on 19.08.2025.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    private func setupTabBar() {
        let homeViewController = setupHomeVewController()

        viewControllers = []
    }

    //MARK: - View Controllers

    private func setupHomeVewController() -> UIViewController {
        let viewController = HomeViewController()

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true

        navigationController.tabBarItem.selectedImage = UIImage(systemName: "home.fill")
        navigationController.tabBarItem.image = UIImage(systemName: "home")
        navigationController.tabBarItem.title = "Home"

        return navigationController

    }
}
