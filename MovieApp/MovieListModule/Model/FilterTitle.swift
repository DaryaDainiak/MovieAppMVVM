//
//  DataHelper.swift
//  MovieApp
//
//  Created by Дайняк Дарья Станиславовна on 08.03.2021.
//

import Foundation

/// Filter Model
struct FilterTitle {
    var filterArray: [Filter] = []

    init() {
        generateFilter()
    }

    mutating func generateFilter() {
        let filter1 = Filter(title: "Топ 100 популярных фильмов", parameter: "TOP_100_POPULAR_FILMS")
        let filter2 = Filter(title: "Топ 250 лучших фильмов", parameter: "TOP_250_BEST_FILMS")
        let filter3 = Filter(title: "Топ ожидаемых фильмов", parameter: "TOP_AWAIT_FILMS")
        filterArray.append(filter1)
        filterArray.append(filter2)
        filterArray.append(filter3)
    }
}
