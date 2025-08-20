//
//  HomeViewController.swift
//  ArtCollection
//
//  Created by Динар Хайруллин on 19.08.2025.
//
import UIKit

final class HomeViewController: UIViewController {

    private let scrollView: UIScrollView = UIScrollView()

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

        //Создаём лейбл Заголовка и сам заголовок
        let imageView = UIImageView(image: UIImage(named: "homeview_image"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = "ArtCollection"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        //Создаём и настраиваем кнопку
        let button = UIButton(type: .system)
        button.setTitle("Random", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.gray.cgColor
        button.setImage(UIImage(systemName: "shuffle"), for: .normal)
        button.tintColor = .black

        //Настраиваем отступы у иконки, кнопки и кэпшна внутри
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: -5, bottom: 5, right: 10)
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        button.contentEdgeInsets = UIEdgeInsets(top: 7, left: 5, bottom: 7, right: 5)
        button.translatesAutoresizingMaskIntoConstraints = false

        // Создаем и настраиваем строку поиска
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search artworks or artists..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.backgroundImage = UIImage()

        // Создаем горизонтальный стек для изображения, заголовка и кнопки
        let topStackView = UIStackView(arrangedSubviews: [imageView, titleLabel, button])
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.spacing = 8
        topStackView.translatesAutoresizingMaskIntoConstraints = false

        // Добавляем элементы в navBarView
        navBarView.addSubview(topStackView)
        navBarView.addSubview(searchBar)

        // Устанавливаем констрейнты: для navBarView
        NSLayoutConstraint.activate([
            navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: 120),

            //Для сейфзоны сверху
            topBackgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            topBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topBackgroundView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            // Для topStackView и searchBar
            topStackView.topAnchor.constraint(equalTo: navBarView.topAnchor, constant: 16),
            topStackView.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor, constant: -16),

            searchBar.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 8),
            searchBar.leadingAnchor.constraint(equalTo: navBarView.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: navBarView.trailingAnchor, constant: -8),
            searchBar.bottomAnchor.constraint(equalTo: navBarView.bottomAnchor, constant: -8),
            searchBar.heightAnchor.constraint(equalToConstant: 36),

            // Для изображения на кнопке
            imageView.widthAnchor.constraint(equalToConstant: 34),
            imageView.heightAnchor.constraint(equalToConstant: 34),

            //Фиксированные размеры для кнопки
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
