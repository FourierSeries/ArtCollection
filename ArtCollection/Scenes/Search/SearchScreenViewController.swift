//
//  SearchScreenViewController.swift
//  ArtCollection
//
//  Created by Alekseeva Olga on 15.08.2025.
//

import UIKit

final class SearchScreenViewController: UIViewController {

    // MARK: - Private Properties
    private let customNavBar = CustomNavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        setupUI()
    }

    // MARK: - Setup
    private func setupUI() {
        setupCustomNavigationBar()
        setupLayout()
    }

    private func setupCustomNavigationBar() {
        view.addSubview(customNavBar)
    }

    // MARK: - Layout
    private func setupLayout() {
        customNavBar.translatesAutoresizingMaskIntoConstraints = false

        // Устанавливаем констрейнты:
        NSLayoutConstraint.activate([

            // Для navBarView
            customNavBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 120)
        ])
    }

    //     MARK: - Actions
    
}

