//
//  FilmDetails.swift
//  MovieApp
//
//  Created by Дайняк Дарья Станиславовна on 11.03.2021.
//

import Foundation

/// FilmDetails
struct FilmDetails: Decodable {
    let data: DataClass
}

/// DataClass
struct DataClass: Decodable {
    let description: String?
}
