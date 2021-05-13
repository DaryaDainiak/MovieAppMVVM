//
// ViewController.swift
//  MovieApp
//
//  Created by Дайняк Дарья Станиславовна on 08.03.2021.
//

import CoreData
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

    private let filterTitle = FilterTitle()
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
    var context: NSManagedObjectContext!

    var viewModel: MovieListViewModelProtocol!
    weak var coordinator: MainCoordinator?

    // MARK: - Lifecycle

    init(viewModel: MovieListViewModelProtocol) {
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

        setUpFilterCollectionView()
        setUpMoviesTableView()
        setUpErrorView()
        setUpDelegate()
        type = filterTitle.filterArray[0].parameter ?? ""
        viewModel.getMovies(type: viewModel.type, currentPage: viewModel.currentPage)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        title = "Movies"
        view.backgroundColor = .white
    }

    // MARK: - Private Methods

    private func bindViewModel() {
        viewModel.dataUpdated = {
            DispatchQueue.main.async {
                self.errorLabel.isHidden = true
                self.moviesTableView.isHidden = false
                self.moviesTableView.reloadData()
            }
        }

        viewModel.showError = { error in
            DispatchQueue.main.async {
                self.errorLabel.isHidden = false
                self.moviesTableView.isHidden = true
                self.view.bringSubviewToFront(self.errorLabel)
            }
            print("Error serialization json \(error)", error.localizedDescription)
        }
    }

    private func setUpFilterCollectionView() {
        filterCollectionView.filters = filterTitle.filterArray
        filterCollectionView.tapClosure = { [weak self] index in
            guard let self = self else { return }

            self.type = self.filterTitle.filterArray[index].parameter ?? ""
            self.currentPage = 1
            self.movieArray.removeAll()
            self.viewModel.getMovies(type: self.viewModel.type, currentPage: self.viewModel.currentPage)
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
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Consts.identifier, for: indexPath) as? MovieTableViewCell
        else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(for: indexPath)
        cell.viewModel = cellViewModel

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
//        guard let viewModel = viewModel else { return }
//        viewModel.selectedRow(atIndexPath: indexPath)
//        guard let detailsViewModel = viewModel.viewModelForSelectedRow() else { return }

        let selectedMoview = viewModel.movieArray[indexPath.row]

        coordinator?.detailsView(film: selectedMoview)
//        let dvc = DetailsViewController(viewModel: detailsViewModel)
//        navigationController?.pushViewController(dvc, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.numberOfRows() - 2 {
            let type = viewModel.type
            viewModel.currentPage += 1
            viewModel.getMovies(type: type, currentPage: currentPage)
        }
    }
}
