//
//  TableSectionProtocol.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 19/04/21.
//

import UIKit

protocol TableSectionProtocol {
    var itemsCount: Int { get }
    func cellType(at row: Int) -> UITableViewCell.Type
    func bindCell(cell: UITableViewCell, at row: Int)
    func didSelectAt(row: Int)
    
    func headerView() -> UIView?
    func headerHeight() -> CGFloat
}

extension TableSectionProtocol {
    
    func headerView() -> UIView? {
        return nil
    }
    
    func headerHeight() -> CGFloat {
        return 0
    }

    func didSelectAt(row: Int) {
    
    }
}

protocol TableViewModelProtocol { }

protocol TableViewProtocol {
    associatedtype ViewModel = TableViewModelProtocol
    func bindIn(viewModel: ViewModel)
}
