//
//  SceneDelegate.swift
//  ArtCollection
//
//  Created by Динар Хайруллин on 19.08.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        let homeViewController = HomeViewController()
        let onboardingViewController = OnboardingViewController()

        // Добавляем HomeViewController как корневой
        window.rootViewController = homeViewController

        // Добавляем OnboardingViewController поверх HomeViewController
        homeViewController.view.addSubview(onboardingViewController.view)
        homeViewController.addChild(onboardingViewController)
        onboardingViewController.didMove(toParent: homeViewController)

        self.window = window
        window.makeKeyAndVisible()
    }
}
