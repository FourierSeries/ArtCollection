//
//  ProfileViewController.swift
//  ArtCollection
//
//  Created by Динар Хайруллин on 19.08.2025.
//

import UIKit

final class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6

        setupCustomNavigationBar()
    }

    //Скрываем UINavigationController, который сделали в TabBArController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func setupCustomNavigationBar() {
        // Создаем представление для фона над navBarView
        let topBackgroundView = UIView()
        topBackgroundView.backgroundColor = .systemBackground // Устанавливаем нужный цвет фона
        topBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(topBackgroundView)

        //Создаём навбар
        let navBarView = UIView()
        navBarView.backgroundColor = .systemBackground
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(navBarView)

        //Создаём заголовок
        let titleLabel = UILabel()
        titleLabel.text = "Profile"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        // Создаем горизонтальный стек для заголовка
        let topStackView = UIStackView(arrangedSubviews: [titleLabel])
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.spacing = 8
        topStackView.translatesAutoresizingMaskIntoConstraints = false

        // Добавляем элементы в navBarView
        navBarView.addSubview(topStackView)

        // Устанавливаем констрейнты:
        NSLayoutConstraint.activate([
            //Для navBarView
            navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: 60),

            //Для сейфзоны сверху
            topBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            // Для topStackView
            topStackView.topAnchor.constraint(equalTo: navBarView.topAnchor, constant: 16),
            topStackView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor, constant: -16)
            ])
    }
}
