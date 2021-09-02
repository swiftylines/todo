//
//  MockToDoListDataProvider.swift
//  ToDoAppTests
//
//  Created by Manish on 02/09/21.
//

@testable import ToDoApp

struct MockToDoListDataProvider: ToDoListDataProvider {
    var todos: [ToDoItem]
}
