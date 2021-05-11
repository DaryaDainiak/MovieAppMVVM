//
//  FilterCollectionView.swift
//  MovieApp
//
//  Created by Дайняк Александр Николаевич on 08.03.2021.
//

import UIKit

///
class FilterCollectionView: UICollectionView {
    struct Consts {
        static let cellHeight: CGFloat = 44
        static let inset: CGFloat = 16
        static let buttonFont = UIFont.systemFont(ofSize: 17)
        static let backgroundColor: UIColor = .white
    }

    var filters: [Filter] = []

    var tapClosure: ((Int) -> Void)?
    var isFirstTime = true

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)

        backgroundColor = Consts.backgroundColor
        delegate = self
        dataSource = self
        register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: FilterCollectionViewCell.reuseId)
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Data Source

extension FilterCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filters.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = dequeueReusableCell(
            withReuseIdentifier: FilterCollectionViewCell.reuseId,
            for: indexPath
        ) as? FilterCollectionViewCell else { return UICollectionViewCell() }
        cell.fill(filter: filters[indexPath.row], index: indexPath.row)

        cell.tapClosure = tapClosure
        cell.clearBackgroundColor = {
            collectionView.visibleCells.forEach { cell in
                let filterCell = cell as? FilterCollectionViewCell
                filterCell?.clearBackgroundButton()
            }
        }

        if indexPath.item == 0, isFirstTime {
            isFirstTime = false
            cell.changeBackgroundButton()
        }

        return cell
    }
}

// MARK: - Delegate

extension FilterCollectionView: UICollectionViewDelegate {}

extension FilterCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let textWidth = filters[indexPath.item].title.widthOfString(usingFont: Consts.buttonFont) + Consts.inset

        return CGSize(width: textWidth, height: Consts.cellHeight)
    }
}

private extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
