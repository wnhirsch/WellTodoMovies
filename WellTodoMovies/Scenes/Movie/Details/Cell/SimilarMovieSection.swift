//
//  SimilarMovieSection.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 19/04/21.
//

import UIKit

class SimilarMovieSection: TableSectionProtocol {

    var viewModels: [SimilarMovieCellProtocol]

    init(viewModels: [SimilarMovieCellProtocol]) {
        self.viewModels = viewModels
    }

    var itemsCount: Int {
        return viewModels.count
    }

    func cellType(at row: Int) -> UITableViewCell.Type {
        SimilarMovieCell.self
    }

    func bindCell(cell: UITableViewCell, at row: Int) {
        guard let cell = cell as? SimilarMovieCell, row < itemsCount else { return }
        cell.bindIn(viewModel: viewModels[row])
    }

    func didSelectAt(row: Int) {
        viewModels[row].onClick?()
    }

    func headerView() -> UIView? {
        return nil
    }

    func headerHeight() -> CGFloat {
        return 0
    }
}
