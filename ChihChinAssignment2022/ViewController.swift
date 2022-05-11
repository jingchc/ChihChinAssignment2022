//
//  ViewController.swift
//  ChihChinAssignment2022
//
//  Created by Jing on 2022/5/11.
//

import UIKit
import Combine

final class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ViewModel()
    private var disposables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindViewModel()
    }
    
    private func setup() {
        
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: TableViewCell.reuseId)
        tableView.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.$orders
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in self?.tableView.reloadData() })  // todo: insert
            .store(in: &disposables)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
        cell.order = viewModel.orders[indexPath.row]
        return cell
    }
    
}
