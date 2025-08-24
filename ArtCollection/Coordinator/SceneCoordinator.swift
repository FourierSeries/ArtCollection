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

    private func switchToDetails(modal: Bool) {
        let detailsViewController = makeDetails()

        if modal {
            // Открыть модально
            detailsViewController.modalPresentationStyle = .pageSheet
            topMostViewController()?.present(detailsViewController, animated: true, completion: nil)
        } else {
            // Открыть в полноэкранном режиме
            if let navigationController = topMostViewController()?.navigationController {
                navigationController.pushViewController(detailsViewController, animated: true)
            } else {
            // Если нет навигационного контроллера, открыть модально как запасной вариант
                topMostViewController()?.present(detailsViewController, animated: true, completion: nil)
            }
        }
    }

    // Функция для получения текущего видимого контроллера
    private func topMostViewController() -> UIViewController? {
        guard let rootViewController = window.rootViewController else {
            return nil
        }
        return topMostViewController(for: rootViewController)
    }

    // Находим самый верхний контроллер, который может быть видимым в навигационном контроллере или выбранным в таббаре
    private func topMostViewController(for rootViewController: UIViewController) -> UIViewController {
        if let presentedViewController = rootViewController.presentedViewController {
            return topMostViewController(for: presentedViewController)
        }
        if let navigationController = rootViewController as? UINavigationController {
            return topMostViewController(for: navigationController.visibleViewController ?? navigationController)
        }
        if let tabBarController = rootViewController as? UITabBarController {
            return topMostViewController(for: tabBarController.selectedViewController ?? tabBarController)
        }
        return rootViewController
    }
}

extension SceneCoordinator: OnboardingDelegate {
    func didTapActionButton() {
        switchToMain()
    }
}

extension SceneCoordinator: HomeDelegate {
    func didTapInfoButton(modal: Bool) {
        switchToDetails(modal: modal)
    }
}

private extension SceneCoordinator {

    func makeMain() -> UIViewController {
        // Создаем экземпляр TabBarController, который уже настроен для использования HomeVC и ProfileVC
        let tabBarController = TabBarController()

            // Находим HomeViewController в массиве viewControllers и устанавливаем для него делегат
            if let homeNavController = tabBarController.viewControllers?.first as? UINavigationController,
               let homeViewController = homeNavController.viewControllers.first as? HomeViewController {
                homeViewController.delegate = self
            }

            return tabBarController
        }

    func makeOnboarding() -> UIViewController {
        let viewController = OnboardingViewController()

        viewController.delegate = self

        return viewController
    }

    func makeDetails() -> UIViewController {
        let viewController = DetailsViewController()

        return viewController
    }
}
