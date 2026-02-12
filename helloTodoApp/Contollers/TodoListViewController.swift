//
//  TodoListViewController.swift
//  helloTodoApp
//
//  Created by Vl on 2/11/26.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDelegate {
    
    var todos: [String] = ["write an essay", "go for a walk with a dog", "read an article"]
    
    let todoTableView: UITableView = {
       let todoTableView = UITableView()
        todoTableView.register(UITableViewCell.self, forCellReuseIdentifier: "TodoCell")
        todoTableView.translatesAutoresizingMaskIntoConstraints = false
        return todoTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        navigationItem.title = "todo list"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(todoTableView)
        
        todoTableView.dataSource = self
        todoTableView.delegate = self
        
        configureConstraints()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openAlert))
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            todoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            todoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            todoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    @objc
    func openAlert() {
        let alert = UIAlertController(title: "Create a new todo", message: "stay motivated :)", preferredStyle: .alert)
        alert.addTextField()
        let addButton = UIAlertAction(title: "OK", style: .default) {_ in
            if let text = alert.textFields?.first?.text {
                self.todos.append(text)
                self.todoTableView.reloadData()
            }
        }
        alert.addAction(addButton)
        let cancelButton = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelButton)
        present(alert, animated: true)
        
    }
    
}

extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "TodoCell")
        let todoItem = todos[indexPath.row]
        cell.textLabel?.text = todoItem
        cell.backgroundColor = .gray
        cell.textLabel?.textColor = .white
        cell.selectionStyle = .none
        return cell
    }
    
    
}

