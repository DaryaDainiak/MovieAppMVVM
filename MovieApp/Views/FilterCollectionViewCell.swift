//
//  FilterCollectionViewCell.swift
//  MovieApp
//
//  Created by Дайняк Дарья Станиславовна on 08.03.2021.
//

import UIKit

/// FilterCollectionViewCell
final class FilterCollectionViewCell: UICollectionViewCell {
    // MARK: - Public Properties

    var tapClosure: ((Int) -> Void)?
    static let reuseId = "FilterCollectionViewCell"
    var clearBackgroundColor: (() -> ())?

    // MARK: - Private Properties

    private var index = 0
    private lazy var filterButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(actionButton), for: .touchUpInside)

        return button
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUpFilterButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func fill(filter: Filter, index: Int) {
        filterButton.setTitle(filter.title, for: .normal)
        self.index = index
    }

    func changeBackgroundButton() {
        filterButton.layer.borderWidth = 2
        filterButton.layer.borderColor = UIColor.systemTeal.cgColor
        filterButton.backgroundColor = .white
    }

    func clearBackgroundButton() {
        filterButton.layer.borderWidth = 0
        filterButton.backgroundColor = .clear
    }

    // MARK: - Private methods

    @objc private func actionButton() {
        clearBackgroundColor?()
        changeBackgroundButton()
        tapClosure?(index)
    }

    private func setUpFilterButton() {
        addSubview(filterButton)
        filterButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        filterButton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        filterButton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
