//
//  MovieTableViewCell.swift
//  MovieApp
//
//  Created by Дайняк Дарья Станиславовна on 09.03.2021.
//

import UIKit

/// MovieTableViewCell
final class MovieTableViewCell: UITableViewCell {
    // MARK: - Private Properties

    private struct Consts {
        static let inset: CGFloat = 8
        static let movieImageWidth: CGFloat = 170
        static let viewCornerRadius: CGFloat = 20
        static let titleHeight: CGFloat = 40
        static let spacing: CGFloat = 16
        static let dateWidth: CGFloat = 110
        static let largeFont: CGFloat = 16
        static let middleFont: CGFloat = 14
        static let smallFont: CGFloat = 12
    }

    private let movieView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = Consts.viewCornerRadius
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        return view
    }()

    private let movieShadowView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white

        return view
    }()

    private let movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill

        return imageView
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .black
        title.textAlignment = .center
        title.font = UIFont.systemFont(ofSize: Consts.middleFont, weight: .bold)
        title.numberOfLines = 2
        title.translatesAutoresizingMaskIntoConstraints = false

        return title
    }()

    private let dateLabel: UILabel = {
        let date = UILabel(frame: .zero)
        date.textColor = .black
        date.textAlignment = .left
        date.font = UIFont.systemFont(ofSize: Consts.smallFont, weight: .regular)
        date.numberOfLines = 1
        date.translatesAutoresizingMaskIntoConstraints = false

        return date
    }()

    private let genresLabel: UILabel = {
        let genres = UILabel(frame: .zero)
        genres.textColor = .black
        genres.textAlignment = .left
        genres.font = UIFont.systemFont(ofSize: Consts.smallFont, weight: .regular)
        genres.numberOfLines = 2
        genres.translatesAutoresizingMaskIntoConstraints = false

        return genres
    }()

    private let countriesLabel: UILabel = {
        let countries = UILabel(frame: .zero)
        countries.textColor = .black
        countries.textAlignment = .left
        countries.font = UIFont.systemFont(ofSize: Consts.smallFont, weight: .regular)
        countries.numberOfLines = 2
        countries.translatesAutoresizingMaskIntoConstraints = false

        return countries
    }()

    private let ratingButton: UIButton = {
        let rating = UIButton(frame: .zero)
        rating.setTitleColor(.systemYellow, for: .normal)
        rating.backgroundColor = .black
        rating.titleLabel?.font = UIFont.systemFont(ofSize: Consts.smallFont, weight: .bold)
        rating.translatesAutoresizingMaskIntoConstraints = false
        rating.layer.cornerRadius = 10
        rating.clipsToBounds = true
        rating.layer.borderWidth = 1
        rating.layer.borderColor = UIColor.systemYellow.cgColor

        return rating
    }()

    weak var viewModel: MovieListCellViewModelProtocol? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            genresLabel.text = viewModel.genres
            countriesLabel.text = viewModel.countries
            ratingButton.setTitle(viewModel.rating, for: .normal)
            DispatchQueue.global().async { [weak self] in
                guard let imageURL = URL(string: viewModel.image) else { return }
                if let data = try? Data(contentsOf: imageURL) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.movieImage.image = image
                        }
                    }
                }
            }
        }
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Public Methods

    func fill(movie: Film) {
//        DispatchQueue.global().async { [weak self] in
//            guard let imageURL = URL(string: movie.posterUrlPreview) else { return }
//            if let data = try? Data(contentsOf: imageURL) {
//                if let image = UIImage(data: data) {
//                    DispatchQueue.main.async {
//                        self?.movieImage.image = image
//                    }
//                }
//            }
//        }
//        titleLabel.text = movie.nameRu
//        var genres: String = ""
//        for index in 0 ..< movie.genres.count {
//            genres += movie.genres[index].genre
//            if index < movie.genres.count - 1 {
//                genres += ", "
//            }
//        }
//        genresLabel.text = "Жанр: \(genres)"

//        var countries: String = ""
//        for index in 0 ..< movie.countries.count {
//            countries += movie.countries[index].country
//            if index < movie.countries.count - 1 {
//                countries += ", "
//            }
//        }
//        countriesLabel.text = "Страны: \(countries)"
//        ratingButton.setTitle(movie.rating, for: .normal)
    }

    // MARK: - Private Methods

    private func setUpViews() {
        contentView.addSubview(movieShadowView)
        contentView.addSubview(movieView)
        movieView.addSubview(movieImage)
        movieView.addSubview(titleLabel)
        movieView.addSubview(genresLabel)
        movieView.addSubview(countriesLabel)
        movieView.addSubview(dateLabel)
        movieView.addSubview(ratingButton)

        movieShadowView.layer.cornerRadius = Consts.viewCornerRadius
        movieShadowView.layer.shadowColor = UIColor.systemGray2.cgColor
        movieShadowView.layer.shadowRadius = 8
        movieShadowView.layer.shadowOffset = CGSize(width: 5, height: 2)
        movieShadowView.layer.shadowOpacity = 0.5

        movieShadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Consts.inset).isActive = true
        movieShadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Consts.inset)
            .isActive = true
        movieShadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Consts.inset)
            .isActive = true
        movieShadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Consts.inset)
            .isActive = true

        movieView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Consts.inset).isActive = true
        movieView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Consts.inset).isActive = true
        movieView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Consts.inset)
            .isActive = true
        movieView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Consts.inset).isActive = true

        movieImage.topAnchor.constraint(equalTo: movieView.topAnchor).isActive = true
        movieImage.leadingAnchor.constraint(equalTo: movieView.leadingAnchor).isActive = true
        movieImage.widthAnchor.constraint(equalToConstant: Consts.movieImageWidth).isActive = true
        movieImage.bottomAnchor.constraint(equalTo: movieView.bottomAnchor).isActive = true

        titleLabel.topAnchor.constraint(equalTo: movieView.topAnchor, constant: Consts.spacing).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: Consts.spacing)
            .isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: movieView.trailingAnchor, constant: -Consts.spacing)
            .isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: Consts.titleHeight).isActive = true

        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: Consts.titleHeight / 2).isActive = true

        genresLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor).isActive = true
        genresLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor).isActive = true
        genresLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor).isActive = true
        genresLabel.heightAnchor.constraint(equalToConstant: Consts.titleHeight).isActive = true

        countriesLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor).isActive = true
        countriesLabel.trailingAnchor.constraint(equalTo: genresLabel.trailingAnchor).isActive = true
        countriesLabel.leadingAnchor.constraint(equalTo: genresLabel.leadingAnchor).isActive = true
        countriesLabel.heightAnchor.constraint(equalToConstant: Consts.titleHeight).isActive = true

        ratingButton.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -Consts.inset).isActive = true
        ratingButton.trailingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: -Consts.inset)
            .isActive = true
    }
}
