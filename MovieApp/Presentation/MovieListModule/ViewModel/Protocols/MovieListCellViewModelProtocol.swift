//
//  MovieListCellViewModelProtocol.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/12/21.
//

import Foundation

protocol MovieListCellViewModelProtocol: AnyObject {
    var image: String { get }
    var title: String { get }
    var genres: String { get }
    var countries: String { get }
    var rating: String { get }
}
