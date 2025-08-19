//
//  AppDelegate.swift
//  ArtCollection
//
//  Created by Alekseeva Olga on 15.08.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let homeViewController = HomeViewController()
        let onboardingViewController = OnboardingViewController()

        // Добавляем HomeViewController как корневой
        window?.rootViewController = homeViewController

        // Добавляем OnboardingViewController поверх HomeViewController
        homeViewController.view.addSubview(onboardingViewController.view)
        homeViewController.addChild(onboardingViewController)
        onboardingViewController.didMove(toParent: homeViewController)

        window?.makeKeyAndVisible()

        return true
    }
}

