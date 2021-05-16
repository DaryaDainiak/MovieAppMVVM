//
//  DetailsViewController.swift
//  MovieApp
//
//  Created by Дайняк Дарья Станиславовна on 09.03.2021.
//

import UIKit

/// DetailsViewController
final class DetailsViewController: UIViewController {
    // MARK: - Public Properties

    var selectedFilm: Film?

    // MARK: - Private Properties

    private struct Consts {
        static let verticalSpacing: CGFloat = 16
        static let horizontalSpacing: CGFloat = 16
        static let imageHeight: CGFloat = 500
    }

    private let detailsScrollView = UIScrollView(frame: .zero)
    private lazy var selectedImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false

        return image
    }()

    private lazy var titleLable: UILabel = {
        let title = UILabel(frame: .zero)
        title.text = viewModel?.selectedMovie?.nameRu
        title.textAlignment = .center
        title.textColor = .black
        title.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        title.numberOfLines = 0
        title.translatesAutoresizingMaskIntoConstraints = false

        return title
    }()

    private let selectedDescription: UILabel = {
        let description = UILabel()
        description.textAlignment = .natural
        description.textColor = .black
        description.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        return description
    }()

    // MARK: - Public Properties

    var viewModel: DetailsViewModelProtocol?
    weak var coordinator: MainCoordinator?

    // MARK: - Lifecycle

    init(viewModel: DetailsViewModelProtocol) {
        self.viewModel = viewModel

        super.init(
            nibName: nil,
            bundle: nil
        )
        bindViewModel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpScrollView()
        viewModel?.getMovieDetails()
        setUpContents()
        setUpScrollContentSize()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        title = "Details"
        view.backgroundColor = .white
    }

    // MARK: - Private Methods

    private func bindViewModel() {
        viewModel?.dataUpdated = {
            DispatchQueue.main.async {
                if let description = self.viewModel?.movieDetails?.data.description {
                    self.selectedDescription.text = description
                    self.setUpScrollContentSize()
                }
            }
        }

        viewModel?.showError = { [weak self] error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.selectedDescription.text = "Oops... Description is missing."
                self.selectedDescription.textColor = .systemRed
            }
            print(error.localizedDescription)
        }
    }

    private func setUpScrollView() {
        view.addSubview(detailsScrollView)
        detailsScrollView.translatesAutoresizingMaskIntoConstraints = false
        detailsScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        detailsScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        detailsScrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        detailsScrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        detailsScrollView.backgroundColor = .white
    }

    private func setUpContents() {
        DispatchQueue.global().async { [weak self] in

            guard let self = self,
                  let imageName = self.viewModel?.selectedMovie?.posterUrlPreview,
                  let imageURL = URL(string: imageName) else { return }
            if let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.selectedImageView.image = image
                    }
                }
            }
        }

        detailsScrollView.addSubview(selectedImageView)

        selectedImageView.topAnchor.constraint(equalTo: detailsScrollView.topAnchor, constant: Consts.verticalSpacing)
            .isActive = true
        selectedImageView.widthAnchor.constraint(
            equalTo: detailsScrollView.widthAnchor,
            constant: -2 * Consts.horizontalSpacing
        )
        .isActive = true
        selectedImageView.centerXAnchor.constraint(equalTo: detailsScrollView.centerXAnchor)
            .isActive = true
        selectedImageView.heightAnchor.constraint(equalToConstant: Consts.imageHeight)
            .isActive = true

        detailsScrollView.addSubview(titleLable)

        titleLable.topAnchor.constraint(equalTo: selectedImageView.bottomAnchor, constant: Consts.verticalSpacing)
            .isActive = true
        titleLable.widthAnchor.constraint(
            equalTo: detailsScrollView.widthAnchor,
            constant: -2 * Consts.horizontalSpacing
        )
        .isActive = true
        titleLable.centerXAnchor.constraint(equalTo: detailsScrollView.centerXAnchor)
            .isActive = true

        detailsScrollView.addSubview(selectedDescription)

        selectedDescription.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: Consts.verticalSpacing)
            .isActive = true
        selectedDescription.widthAnchor.constraint(
            equalTo: detailsScrollView.widthAnchor,
            constant: -2 * Consts.horizontalSpacing
        )
        .isActive = true
        selectedDescription.centerXAnchor.constraint(equalTo: detailsScrollView.centerXAnchor)
            .isActive = true
    }

    private func setUpScrollContentSize() {
        detailsScrollView.contentSize = CGSize(
            width: view.bounds.width,
            height: Consts.imageHeight + titleLable.intrinsicContentSize.height + selectedDescription
                .intrinsicContentSize.height + Consts
                .verticalSpacing * 3
        )
        detailsScrollView.isScrollEnabled = true
    }
}
