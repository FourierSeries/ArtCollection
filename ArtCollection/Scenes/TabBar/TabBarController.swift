//
//  TabBarController.swift
//  ArtCollection
//
//  Created by Динар Хайруллин on 19.08.2025.
//

import UIKit

final class TabBarController: UITabBarController {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupTabBar()
    }

    // MARK: - Setup

    private func setupUI() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }

    private func setupTabBar() {
        let homeViewController = setupHomeVewController()
        let settingsViewController = setupSettingsVewController()

        viewControllers = [homeViewController, settingsViewController]
    }
}


    private extension TabBarController {

    // MARK: - View Controllers
    func setupHomeVewController() -> UIViewController {
        let viewController = HomeViewController()
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true

        navigationController.tabBarItem.selectedImage = UIImage(systemName: "house.fill")
        navigationController.tabBarItem.image = UIImage(systemName: "house")
        navigationController.tabBarItem.title = "Home"

        return navigationController
    }

    func setupSettingsVewController() -> UIViewController {
        let viewController = ProfileViewController()
        viewController.title = "Profile"

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true

        navigationController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        navigationController.tabBarItem.image = UIImage(systemName: "person")
        navigationController.tabBarItem.title = "Profile"

        return navigationController
    }
}
