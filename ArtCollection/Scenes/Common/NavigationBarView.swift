//
//  NavigationBarView.swift
//  ArtCollection
//
//  Created by Alekseeva Olga on 24.08.2025.
//

import UIKit

final class CustomNavigationBar: UIView {

    // MARK: - Callbacks
        var onRandomButtonTapped: (() -> Void)?

    // MARK: - UI Elements
    private let imageView = UIImageView(image: UIImage(named: "homeview_image"))
    private let titleLabel = UILabel()
    let randomButton = UIButton(type: .system)
    private let searchBar = UISearchBar()
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Methods
    private func setupUI() {
        backgroundColor = .systemBackground

        imageView.contentMode = .scaleAspectFit

        titleLabel.text = "ArtCollection"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)

        randomButton.setTitle("Random", for: .normal)
        randomButton.setTitleColor(.black, for: .normal)
        randomButton.setTitleColor(.lightGray, for: .disabled)
        randomButton.backgroundColor = .white
        randomButton.layer.cornerRadius = 10
        randomButton.layer.borderWidth = 1
        randomButton.layer.borderColor = UIColor.lightGray.cgColor
        randomButton.setImage(UIImage(systemName: "shuffle"), for: .normal)
        randomButton.tintColor = .black
        randomButton.isEnabled = false

        searchBar.placeholder = "Search artworks or artists..."
        searchBar.backgroundImage = UIImage()

        topStackView.addArrangedSubview(imageView)
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(randomButton)

        addSubview(topStackView)
        addSubview(searchBar)

        // Добавляем обработчики событий для изменения цвета границы
                randomButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
                randomButton.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])

        // Обработчик для нажатия
        randomButton.addTarget(self, action: #selector(didTapRandomButton), for: .touchUpInside)
    }

    @objc private func didTapRandomButton() {
            onRandomButtonTapped?()
        }

    private func setupLayout() {
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            topStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            searchBar.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 36),

            imageView.widthAnchor.constraint(equalToConstant: 34),
            imageView.heightAnchor.constraint(equalToConstant: 34),

            randomButton.widthAnchor.constraint(equalToConstant: 120),
            randomButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    //     MARK: - Button Actions
        @objc private func buttonTouchDown() {
            randomButton.layer.borderColor = UIColor.lightGray.cgColor // Изменяем цвет границы при нажатии
        }

        @objc private func buttonTouchUp() {
            randomButton.layer.borderColor = UIColor.black.cgColor // Возвращаем цвет границы при отпускании
        }
}
