//
//  DetailsViewController.swift
//  ArtCollection
//
//  Created by Deriabina Sofiia on 24.08.2025.
//

import UIKit

final class DetailsViewController: UIViewController {

    // MARK: - Private Properties
    private let textLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemGray6
        setupUI()
        setupLayout()
    }

    private func setupUI() {
        setupTextView()
    }

    private func setupTextView() {
        textLabel.text = "Тут пока заглушка"
        textLabel.font = UIFont.boldSystemFont(ofSize: 24)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
    }

    // MARK: - Layout
    private func setupLayout() {
        view.addSubview(textLabel)

        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -16)
        ])
    }
}
