//
//  TableViewDataSource.swift
//  WellTodoMovies
//
//  Created by Wellington Nascente Hirsch on 19/04/21.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    weak var scrollDelegate: UIScrollViewDelegate?

    var tableView: UITableView? {
        didSet {
            _delegate = tableView?.delegate
            tableView?.delegate = self
            tableView?.dataSource = self
            registerNibs()
        }
    }

    var sections: [TableSectionProtocol] = [] {
        didSet {
            tableView?.reloadData()
            registerNibs()
        }
    }
    
    private weak var _delegate: UITableViewDelegate?
    
    private func registerNibs() {
        for section in sections {
            for index in 0...section.itemsCount {
                tableView?.registerNib(section.cellType(at: index))
            }
        }
    }

    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].itemsCount
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return sections[section].headerView()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].headerHeight()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.section]
        let row = indexPath.row
        
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: section.cellType(at: row))
        section.bindCell(cell: cell, at: row)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        sections[indexPath.section].didSelectAt(row: indexPath.row)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll?(scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidEndDecelerating?(scrollView)
    }
}
