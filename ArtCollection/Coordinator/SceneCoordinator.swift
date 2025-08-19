//
//  SceneCoordinator.swift
//  ArtCollection
//
//  Created by Alekseeva Olga on 16.08.2025.
//

import UIKit

final class SceneCoordinator {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

//    func start(isAuthorized: Bool) {
//        if isAuthorized {
//            window.rootViewController = makeMain()
//        } else {
//            window.rootViewController = makeOnboarding()
//        }

//    guard let windowScene = (scene as? UIWindowScene) else { return }
//
//            let window = UIWindow(windowScene: windowScene)
//            let homeViewController = HomeViewController()
//            let onboardingViewController = OnboardingViewController()
//
//            // Добавляем HomeViewController как корневой
//            window.rootViewController = homeViewController
//
//            // Добавляем OnboardingViewController поверх HomeViewController
//            homeViewController.view.addSubview(onboardingViewController.view)
//            homeViewController.addChild(onboardingViewController)
//            onboardingViewController.didMove(toParent: homeViewController)
//
//            self.window = window
//            window.makeKeyAndVisible()

    func start() {
        window.rootViewController = makeOnboarding()

        window.makeKeyAndVisible()
    }

    private func switchToMain() {
        let mainViewController = makeMain()

        guard let snapshot = window.snapshotView(afterScreenUpdates: true) else {
            return
        }

        mainViewController.view.addSubview(snapshot)
        window.rootViewController = mainViewController

        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: {
            snapshot.alpha = 0
        }, completion: { _ in
            snapshot.removeFromSuperview()
        })
    }
}

extension SceneCoordinator: OnboardingDelegate {
    func didTapActionButton() {
        switchToMain()
    }
}

private extension SceneCoordinator {

    func makeMain() -> UIViewController {

        return HomeViewController()
    }

    func makeOnboarding() -> UIViewController {
        let viewController = OnboardingViewController()

        viewController.delegate = self

        return viewController
    }
}
