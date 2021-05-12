//
//  MovieListProtocol.swift
//  MovieApp
//
//  Created by Darya Dainiak on 5/12/21.
//

import Foundation

protocol MovieListProtocol: AnyObject {
    func success()
    func failure(error: Error)
}
