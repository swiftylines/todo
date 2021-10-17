//
//  ToDoListView+UITableViewDelegate.swift
//  ToDoApp
//
//  Created by Manish on 04/09/21.
//

import UIKit

extension ToDoListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            self.viewModel?.deleteToDo(at: indexPath.row)
        }
    }
    
}
