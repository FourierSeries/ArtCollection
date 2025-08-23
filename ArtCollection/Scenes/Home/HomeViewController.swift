//
//  HomeViewController.swift
//  ArtCollection
//
//  Created by Динар Хайруллин on 19.08.2025.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Private Properties
    private let topBackgroundView = UIView()
    private let navBarView = UIView()
    private let imageView = UIImageView(image: UIImage(named: "homeview_image"))
    private let titleLabel = UILabel()
    private let randomButton = UIButton(type: .system)
    private let searchBar = UISearchBar()

    private let objectView = UIView()
    private let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private let loadingImageView = UIImageView()
    private let objectImageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let placeholderImageView = UIImageView(image: UIImage(named: "placeholder"))
    private var objectIDs: [Int] = []
    private var currentTask: URLSessionDataTask?
    private let objectTitleLabel = UILabel()
    private let authorTitleLabel = UILabel()
    private let objectDateDepartmentLabel = UILabel()
    private let classificationLabel = UIButton(type: .system)
    private let heartButton = UIButton(type: .system)
    private let infoButton = UIButton(type: .system)

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6

        fetchArtObjectIfNeeded()
        setupUI()
    }

    // Скрываем UINavigationController, который сделали в TabBarController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    // MARK: - Setup
    private func setupUI() {
        setupCustomNavigationBar()
        setupRoundedView()
        setupLayout()
    }

    private func setupCustomNavigationBar() {
        // Настраиваем область для кастомного навбара
        topBackgroundView.backgroundColor = .systemBackground
        view.addSubview(topBackgroundView)

        // Настраиваем навбар
        navBarView.backgroundColor = .systemBackground
        view.addSubview(navBarView)

        // Настраиваем лейбл заголовка и сам заголовок
        imageView.contentMode = .scaleAspectFit

        titleLabel.text = "ArtCollection"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)

        // Настраиваем кнопку на навбаре
        randomButton.setTitle("Random", for: .normal)
        randomButton.setTitleColor(.black, for: .normal)
        randomButton.setTitleColor(.lightGray, for: .disabled) // Устанавливаем цвет для disabled
        randomButton.backgroundColor = .white
        randomButton.layer.cornerRadius = 10
        randomButton.layer.borderWidth = 1
        randomButton.layer.borderColor = UIColor.lightGray.cgColor
        randomButton.setImage(UIImage(systemName: "shuffle"), for: .normal)
        randomButton.tintColor = .black
        randomButton.isEnabled = false

        // Добавляем обработчики событий для изменения цвета границы
        randomButton.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        randomButton.addTarget(self, action: #selector(buttonTouchUp), for: [.touchUpInside, .touchUpOutside, .touchCancel])

        // Обработчик для нажатия
        randomButton.addTarget(self, action: #selector(didTapRandomButton), for: .touchUpInside)

        // Настраиваем строку поиска
        searchBar.placeholder = "Search artworks or artists..."
        searchBar.backgroundImage = UIImage()

        // Добавляем элементы в topStackView
        topStackView.addArrangedSubview(imageView)
        topStackView.addArrangedSubview(titleLabel)
        topStackView.addArrangedSubview(randomButton)

        // Добавляем элементы в navBarView
        navBarView.addSubview(topStackView)
        navBarView.addSubview(searchBar)
    }

    private func setupRoundedView() {
        // Настраиваем область, куда расположим картинку, автора, название
        objectView.backgroundColor = .white
        objectView.layer.cornerRadius = 16
        objectView.layer.shadowColor = UIColor.black.cgColor
        objectView.layer.shadowOpacity = 0.2
        objectView.layer.shadowOffset = CGSize(width: 0, height: 2)
        objectView.layer.shadowRadius = 8
        objectView.isHidden = true
        view.addSubview(objectView)

        // Настраиваем loadingImageView, который будет расширяться в objectView
        loadingImageView.backgroundColor = .systemGray5
        loadingImageView.layer.shadowColor = UIColor.black.cgColor
        loadingImageView.layer.shadowOpacity = 0.2
        loadingImageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        loadingImageView.layer.shadowRadius = 8
        view.addSubview(loadingImageView)

        // Настраиваем ImageView в области для картины
        objectImageView.backgroundColor = .systemGray5
        objectImageView.contentMode = .scaleAspectFit
        objectImageView.clipsToBounds = true
        objectView.addSubview(objectImageView)

        // Настройка для тайтла объекта
        objectTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        objectTitleLabel.textColor = .black
        objectTitleLabel.numberOfLines = 2
        objectTitleLabel.lineBreakMode = .byTruncatingTail
        objectView.addSubview(objectTitleLabel)

        // Настройка для authorTitleLabel
        authorTitleLabel.font = UIFont.systemFont(ofSize: 14)
        authorTitleLabel.textColor = .darkGray
        authorTitleLabel.numberOfLines = 1
        authorTitleLabel.lineBreakMode = .byTruncatingTail
        objectView.addSubview(authorTitleLabel)

        // Настройка для objectDateDepartmentLabel
        objectDateDepartmentLabel.font = UIFont.systemFont(ofSize: 12)
        objectDateDepartmentLabel.textColor = .darkGray
        objectDateDepartmentLabel.numberOfLines = 1
        objectDateDepartmentLabel.lineBreakMode = .byTruncatingTail
        objectView.addSubview(objectDateDepartmentLabel)

        // Настройка activityIndicator
        activityIndicator.hidesWhenStopped = true
        loadingImageView.addSubview(activityIndicator)

        // Настройка и добавление placeholderImageView
        placeholderImageView.contentMode = .scaleAspectFit
        placeholderImageView.isHidden = true
        objectImageView.addSubview(placeholderImageView)

        // Настройка для classificationLabel
        classificationLabel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        classificationLabel.setTitleColor(.black, for: .normal)
        classificationLabel.layer.borderWidth = 1.0
        classificationLabel.layer.borderColor = UIColor.black.cgColor
        classificationLabel.layer.cornerRadius = 5
        classificationLabel.clipsToBounds = true
        classificationLabel.isEnabled = false
        classificationLabel.contentEdgeInsets = UIEdgeInsets(top: 3, left: 6, bottom: 3, right: 6)  // Добавляем отступы
        objectView.addSubview(classificationLabel)

        // Настройка для heartButton
        heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        heartButton.tintColor = .black
        objectView.addSubview(heartButton)

        // Настройка для infoButton
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.tintColor = .black
        objectView.addSubview(infoButton)

        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        tapGesture.minimumPressDuration = 0.1
        objectView.addGestureRecognizer(tapGesture)
    }

    // MARK: - Layout
    private func setupLayout() {
        topBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        navBarView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        randomButton.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        objectView.translatesAutoresizingMaskIntoConstraints = false
        loadingImageView.translatesAutoresizingMaskIntoConstraints = false
        objectImageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        placeholderImageView.translatesAutoresizingMaskIntoConstraints = false
        objectTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        objectDateDepartmentLabel.translatesAutoresizingMaskIntoConstraints = false
        classificationLabel.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false

        // Настраиваем отступы у иконки, кнопки и кэпшна внутри
        randomButton.imageView?.contentMode = .scaleAspectFit
        randomButton.imageEdgeInsets = UIEdgeInsets(top: 5, left: -5, bottom: 5, right: 10)
        randomButton.titleEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        randomButton.contentEdgeInsets = UIEdgeInsets(top: 7, left: 5, bottom: 7, right: 5)

        // Устанавливаем констрейнты:
        NSLayoutConstraint.activate([
            // Для navBarView
            navBarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navBarView.heightAnchor.constraint(equalToConstant: 120),

            // Для сейфзоны сверху
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

            // Фиксированные размеры для кнопки
            randomButton.widthAnchor.constraint(equalToConstant: 120),
            randomButton.heightAnchor.constraint(equalToConstant: 40),

            // Для области с объектом
            objectView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            objectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            objectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            objectView.heightAnchor.constraint(equalToConstant: 500),

            // Начальные констрейнты для loadingImageView
            loadingImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 130),
            loadingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            loadingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            loadingImageView.heightAnchor.constraint(equalToConstant: 360),

            // Для objectImageView
            objectImageView.topAnchor.constraint(equalTo: objectView.topAnchor),
            objectImageView.leadingAnchor.constraint(equalTo: objectView.leadingAnchor),
            objectImageView.trailingAnchor.constraint(equalTo: objectView.trailingAnchor),
            objectImageView.heightAnchor.constraint(equalToConstant: 360),

            // Для objectTitleLabel
            objectTitleLabel.topAnchor.constraint(equalTo: objectImageView.bottomAnchor, constant: 16),
            objectTitleLabel.leadingAnchor.constraint(equalTo: objectView.leadingAnchor, constant: 12),
            objectTitleLabel.trailingAnchor.constraint(equalTo: objectView.trailingAnchor, constant: -12),

            // Для authorTitleLabel
            authorTitleLabel.topAnchor.constraint(equalTo: objectTitleLabel.bottomAnchor, constant: 8),
            authorTitleLabel.leadingAnchor.constraint(equalTo: objectView.leadingAnchor, constant: 12),
            authorTitleLabel.trailingAnchor.constraint(equalTo: objectView.trailingAnchor, constant: -12),

            // Для objectDateDepartmentLabel
            objectDateDepartmentLabel.topAnchor.constraint(equalTo: authorTitleLabel.bottomAnchor, constant: 8),
            objectDateDepartmentLabel.leadingAnchor.constraint(equalTo: objectView.leadingAnchor, constant: 12),
            objectDateDepartmentLabel.trailingAnchor.constraint(equalTo: objectView.trailingAnchor, constant: -12),

            // Для classificationLabel
            classificationLabel.leadingAnchor.constraint(equalTo: objectView.leadingAnchor, constant: 14),
            classificationLabel.bottomAnchor.constraint(equalTo: objectView.bottomAnchor, constant: -10),
            classificationLabel.heightAnchor.constraint(equalToConstant: 20),
            classificationLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 50),

            // Для heartButton
            heartButton.trailingAnchor.constraint(equalTo: infoButton.leadingAnchor, constant: -12),
            heartButton.centerYAnchor.constraint(equalTo: classificationLabel.centerYAnchor),
            heartButton.widthAnchor.constraint(equalToConstant: 20),
            heartButton.heightAnchor.constraint(equalToConstant: 18),

            // Для infoButton
            infoButton.trailingAnchor.constraint(equalTo: objectView.trailingAnchor, constant: -14),
            infoButton.centerYAnchor.constraint(equalTo: classificationLabel.centerYAnchor),
            infoButton.widthAnchor.constraint(equalToConstant: 18),
            infoButton.heightAnchor.constraint(equalToConstant: 18),

            // Для лоадера
            activityIndicator.centerXAnchor.constraint(equalTo: loadingImageView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingImageView.centerYAnchor),

            // Для плейсхолдера при отсутствии картинки
            placeholderImageView.centerXAnchor.constraint(equalTo: objectImageView.centerXAnchor),
            placeholderImageView.centerYAnchor.constraint(equalTo: objectImageView.centerYAnchor),
            placeholderImageView.widthAnchor.constraint(equalToConstant: 50), // Размер заглушки
            placeholderImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Button Actions
    @objc private func buttonTouchDown() {
        randomButton.layer.borderColor = UIColor.lightGray.cgColor // Изменяем цвет границы при нажатии
    }

    @objc private func buttonTouchUp() {
        randomButton.layer.borderColor = UIColor.black.cgColor // Возвращаем цвет границы при отпускании
    }

    @objc
    private func didTapRandomButton() {
        // Отменяем текущую задачу, если она еще не завершена
        currentTask?.cancel()
        currentTask = nil

        // Очищаем изображения и показываем индикатор загрузки
        objectImageView.image = nil
        loadingImageView.image = nil
        randomButton.isEnabled = false
        randomButton.layer.borderColor = UIColor.lightGray.cgColor

        // Скрываем objectView и показываем loadingImageView
        objectView.isHidden = true
        loadingImageView.isHidden = false

        fetchArtObjectIfNeeded()
    }

    //MARK: Update Labels
    private func updateAuthorTitleLabel(artistPrefix: String, artistDisplayName: String, artistNationality: String) {
        var authorText = ""

        // Добавляем префикс, если он не пустой и добавляем к нему пробел в конце
        if !artistPrefix.isEmpty {
            authorText += artistPrefix + " "
        }

        // Добавляем имя и национальность, если имя не пустое
        if !artistDisplayName.isEmpty {
            authorText += artistDisplayName
            if !artistNationality.isEmpty {
                authorText += ", " + artistNationality
            }
        }

        authorTitleLabel.text = authorText
        authorTitleLabel.isHidden = authorText.isEmpty
    }

    private func updateObjectDateDepartmentLabel(objectDate: String, department: String) {
        var dateDepartmentText = ""

        // Добавляем objectDate и department, если objectDate не пустой
        if !objectDate.isEmpty {
            dateDepartmentText = "\(objectDate) · \(department)"
        } else {
            dateDepartmentText = department
        }

        objectDateDepartmentLabel.text = dateDepartmentText
        objectDateDepartmentLabel.isHidden = dateDepartmentText.isEmpty
    }

    private func updateClassificationLabel(classification: String) {
        classificationLabel.setTitle(classification, for: .normal)
        classificationLabel.isHidden = classification.isEmpty
    }

    @objc
    private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let view = gesture.view else { return }

        switch gesture.state {
        // При лонгтапе увеличиваем область на 3%
        case .began:
            UIView.animate(withDuration: 0.2) {
                view.transform = CGAffineTransform(scaleX: 1.03, y: 1.03)
            }
        case .ended, .cancelled:
            UIView.animate(withDuration: 0.2) {
                view.transform = .identity
            }
        default:
            break
        }
    }

    // MARK: API
    private func fetchArtObjectIfNeeded() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
        }

        if objectIDs.isEmpty {
            ArtAPI.fetchAllObjectIDs { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let ids):
                        self?.objectIDs = ids
                        self?.fetchRandomArtObject()
                    case .failure(let error):
                        self?.handleError(error)
                    }
                }
            }
        } else {
            fetchRandomArtObject()
        }
    }

    private func fetchRandomArtObject() {
        guard let randomObjectID = objectIDs.randomElement() else { return }
        ArtAPI.fetchArtObject(with: randomObjectID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let artObject):
                    self?.processArtObject(artObject)
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        }
    }

    private func handleError(_ error: APIError) {
        print(error.localizedDescription)
        DispatchQueue.main.async {
            // Останавливаем индикатор активности в случае ошибки
            self.activityIndicator.stopAnimating()
            // Обновляем интерфейс в случае ошибки
            self.loadingImageView.isHidden = true
            self.objectView.isHidden = false
            self.placeholderImageView.isHidden = false
            self.randomButton.isEnabled = true
            self.randomButton.layer.borderColor = UIColor.black.cgColor
        }
    }

    private func processArtObject(_ artObject: ArtObject) {
        // Проверяем наличие изображения
        if !artObject.primaryImage.isEmpty {
            if let imageUrl = URL(string: artObject.primaryImage) {
                loadImage(from: imageUrl)
            }
        } else {
            fetchRandomArtObject()
            return
        }

        // Обновляем заголовок объекта
        objectTitleLabel.text = artObject.title
        objectTitleLabel.isHidden = artObject.title.isEmpty

        // Обновляем информацию об авторе
        updateAuthorTitleLabel(
            artistPrefix: artObject.artistPrefix,
            artistDisplayName: artObject.artistDisplayName,
            artistNationality: artObject.artistNationality
        )

        // Обновляем информацию о дате и департаменте
        updateObjectDateDepartmentLabel(
            objectDate: artObject.objectDate,
            department: artObject.department
        )

        // Обновляем classification
        updateClassificationLabel(classification: artObject.classification)
    }

    private func loadImage(from url: URL) {
        currentTask?.cancel()

        ImageAPI.loadImage(from: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.objectImageView.image = image
                    self?.randomButton.isEnabled = true
                    self?.loadingImageView.isHidden = true
                    self?.placeholderImageView.isHidden = true
                    self?.objectView.isHidden = false
                case .failure(let error):
                    print("Failed to load image: \(error.localizedDescription)")
                    // Обновляем интерфейс в случае ошибки загрузки изображения
                    self?.loadingImageView.isHidden = true
                    self?.objectView.isHidden = false
                    self?.placeholderImageView.isHidden = false
                    self?.randomButton.isEnabled = true
                }
            }
        }
    }
}
