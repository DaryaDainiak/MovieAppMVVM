//
//  Filter.swift
//  MovieApp
//
//  Created by Дайняк Дарья Станиславовна on 08.03.2021.
//

import Foundation

/// Filter
struct Filter {
    let title: String
    let parameter: String?

    init(title: String, parameter: String? = nil) {
        self.title = title
        self.parameter = parameter
    }
}
