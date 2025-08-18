//
//  OnboardingViewController.swift
//  ArtCollection
//
//  Created by Alekseeva Olga on 16.08.2025.
//

import UIKit

protocol OnboardingDelegate: AnyObject {
    func didTapActionButton()
}

final class OnboardingViewController: UIViewController {

    // MARK: - Private properties
    private let scrollView: UIScrollView = UIScrollView()
    private let contentView: UIView = UIView()

    private let imageView: UIImageView = UIImageView()
    private let descriptionLabel: UILabel = UILabel()
    private let actionButton: UIButton = UIButton()

    weak var delegate: OnboardingDelegate?

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupLayout()
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .init(red: 224/255, green: 164/255, blue: 73/255, alpha: 1.0)

        imageView.image = UIImage(named: "onboarding_image")

        setupDescriptionLabel()
        setupActionButton()

        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bouncesVertically = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubviews(imageView, descriptionLabel, actionButton)
    }

    private func setupDescriptionLabel() {
//        параметры дескрипшена онбординга
        descriptionLabel.text = String(localized: "onboarding_description")
        descriptionLabel.font = .systemFont(ofSize: 14)
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
    }

    private func setupActionButton() {
//        параметры экшн баттона
        actionButton.setTitle("Let's go!", for: .normal)
        actionButton.titleLabel?.font = .boldSystemFont(ofSize: 19)
        actionButton.backgroundColor = .brown
        actionButton.layer.cornerRadius = 14

        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc
    private func didTapActionButton() {
        delegate?.didTapActionButton()
    }

    // MARK: - Layout

    private func setupLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false

        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true

        contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true

        imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.ImageView.topMargin).isActive = true
        imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.ImageView.leftMargin).isActive = true
        imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.ImageView.rightMargin).isActive = true

        //разобраться как эта хрень работает
        if let imageSize = imageView.image?.size, imageSize.width != 0 {
                    imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: imageSize.height / imageSize.width).isActive = true
                }

        descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 21).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -21).isActive = true

        actionButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 200).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -22).isActive = true
        actionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -80).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
    }
}

private extension OnboardingViewController {
// сюда засунуть нужные отступы для пикчи
    struct Constants {
        struct ImageView {
            static let topMargin: CGFloat = 200
            static let leftMargin: CGFloat = 16
            static let rightMargin: CGFloat = -16
            static let aspectRatio: CGFloat = 0.5
        }
    }
}
