//
//  LoadingSection.swift
//  Muvver
//
//  Created by Wellington Nascente Hirsch on 25/04/21.
//

import UIKit

class LoadingSection: TableSectionProtocol {

    var itemsCount: Int {
        return 1
    }

    func cellType(at row: Int) -> UITableViewCell.Type {
        LoadingCell.self
    }

    func bindCell(cell: UITableViewCell, at row: Int) {
        if let cell = cell as? LoadingCell {
            cell.animate()
        }
    }
}
