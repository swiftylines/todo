//
//  ToDoListView+UITableViewDataSource.swift
//  ToDoApp
//
//  Created by Manish on 04/09/21.
//

import UIKit

extension ToDoListView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.todos.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.todoTableView.dequeue(UITableViewCell.self) {
            cell.textLabel?.text = self.viewModel?.todos[indexPath.row].description
        }
        
        return UITableViewCell()
    }
    
}
