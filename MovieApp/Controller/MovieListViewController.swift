//
// ViewController.swift
//  MovieApp
//
//  Created by Дайняк Дарья Станиславовна on 08.03.2021.
//

import UIKit

/// MovieListViewController
final class MovieListViewController: UIViewController {
    // MARK: - Private Properties

    private struct Consts {
        static let collectionViewHeight: CGFloat = 45.0
        static let tableViewBackground: UIColor = .white
        static let verticalSpacing: CGFloat = 10.0
        static let identifier: String = "movieCell"
    }

    private let dataHelper = DataHelper()
    private lazy var filterCollectionView = FilterCollectionView()
    private lazy var moviesTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = Consts.tableViewBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false

        return tableView
    }()

    private lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Сервис не досупен"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true

        return label
    }()

    private var movieArray: [Film] = []
    private var currentPage = 1
    private var type: String = ""

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpFilterCollectionView()
        setUpMoviesTableView()
        setUpErrorView()
        setUpDelegate()
        type = dataHelper.filterArray[0].parameter ?? ""
        fetchData(type: type, currentPage: currentPage)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        title = "Movies"
        view.backgroundColor = .white
    }

    // MARK: - Private Methods

    private func fetchData(type: String, currentPage: Int) {
        let urlString =
            "https://kinopoiskapiunofficial.tech/api/v2.2/films/top?type=\(type)&page=\(currentPage)"
        let components = URLComponents(string: urlString)
        guard let url = components?.url else { return }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["X-API-KEY": "36d1910f-1de8-413f-89dc-665968e24647"]
        URLSession.shared.dataTask(with: request) { data, _, error in

            guard let data = data else { return }
            do {
                let filmsApi = try JSONDecoder().decode(FilmsApi.self, from: data)
                if filmsApi.films.isEmpty {
                    self.currentPage -= 1
                    return
                }

                self.movieArray.append(contentsOf: filmsApi.films)
                DispatchQueue.main.async {
                    self.errorLabel.isHidden = true
                    self.moviesTableView.isHidden = false
                    self.moviesTableView.reloadData()
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorLabel.isHidden = false
                    self.moviesTableView.isHidden = true
                    self.view.bringSubviewToFront(self.errorLabel)
                }
                print("Error serialization json \(error)", error.localizedDescription)
            }
        }.resume()
    }

    private func setUpFilterCollectionView() {
        filterCollectionView.filters = dataHelper.filterArray
        filterCollectionView.tapClosure = { [weak self] index in
            guard let self = self else { return }

            self.type = self.dataHelper.filterArray[index].parameter ?? ""
            self.currentPage = 1
            self.movieArray.removeAll()
            self.fetchData(type: self.type, currentPage: self.currentPage)
        }
        view.addSubview(filterCollectionView)
        filterCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        filterCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        filterCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        filterCollectionView.heightAnchor.constraint(equalToConstant: Consts.collectionViewHeight).isActive = true
    }

    private func setUpErrorView() {
        view.addSubview(errorLabel)
        errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    private func setUpMoviesTableView() {
        view.addSubview(moviesTableView)
        moviesTableView.topAnchor.constraint(
            equalTo: filterCollectionView.bottomAnchor,
            constant: Consts.verticalSpacing
        ).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        moviesTableView.register(MovieTableViewCell.self, forCellReuseIdentifier: Consts.identifier)
    }

    private func setUpDelegate() {
        moviesTableView.delegate = self
        moviesTableView.dataSource = self
    }
}

// MARK: - Extension Data Source

extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Consts.identifier, for: indexPath) as? MovieTableViewCell
        else { return UITableViewCell() }
        let movieInfo = movieArray[indexPath.row]
        cell.fill(movie: movieInfo)

        return cell
    }
}

// MARK: - Extension Delegate

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let dvc = DetailsViewController()
        dvc.selectedFilm = movieArray[indexPath.row]
        navigationController?.pushViewController(dvc, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == movieArray.count - 2 {
            currentPage += 1
            fetchData(type: type, currentPage: currentPage)
        }
    }
}
