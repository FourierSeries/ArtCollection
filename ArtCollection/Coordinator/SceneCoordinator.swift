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

        UIView.animate(withDuration: 0.3) {
            snapshot.alpha = 0
        } completion: { _ in
            snapshot.removeFromSuperview()
        }
    }
}

extension SceneCoordinator: OnboardingDelegate {
    func didTapActionButton() {
        switchToMain()
    }
}

private extension SceneCoordinator {

    func makeMain() -> UIViewController {
        return TabBarController()
    }

    func makeOnboarding() -> UIViewController {
        let viewController = OnboardingViewController()

        viewController.delegate = self

        return viewController
    }
}
