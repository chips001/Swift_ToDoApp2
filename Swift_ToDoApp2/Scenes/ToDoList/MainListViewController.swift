//
//  ToDoListViewController.swift
//  Swift_ToDoApp2
//
//  Created by 一木 英希 on 2019/02/25.
//  Copyright © 2019 一木 英希. All rights reserved.
//

import UIKit

class MainListViewController: UIViewController {
    
    var contentsKind: ContentsKind?
    var todoList = [Todo]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBarButtonItem(viewController: self)
        
        let userDefaults = UserDefaults.standard
        if let storedToDoList = userDefaults.object(forKey: "todolist") as? Data,
            let unarchiveTodoList = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(storedToDoList) as? [Todo],
            let unarchivedTodoList = unarchiveTodoList {
            self.todoList.append(contentsOf: unarchivedTodoList)
        }
    }
    
    private func setupBarButtonItem(viewController : UIViewController) {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked(sender:)))
        viewController.navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func addButtonClicked(sender: UIBarButtonItem) {
        let arertViewController = UIAlertController(
            title: "TODO追加",
            message: "TODOを入力して下さい",
            preferredStyle: .alert
        )
        arertViewController.addTextField(configurationHandler: nil)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default
        ) { action in
            if let textField = arertViewController.textFields?.first, let text = textField.text {
                let todo = Todo()
                todo.todoTitle = text
                self.todoList.insert(todo, at: 0)
                self.toDoListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .right)
                self.saveToUserDefaultsWithTodolist()
            }
        }
        arertViewController.addAction(okAction)
        
        let cancelAction = UIAlertAction(
            title: "CANCEL",
            style: .cancel,
            handler: nil
        )
        arertViewController.addAction(cancelAction)
        
        self.present(arertViewController, animated: true, completion: nil)
    }
    
    private func saveToUserDefaultsWithTodolist() {
        let userDefaults = UserDefaults.standard
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: self.todoList, requiringSecureCoding: false) {
            userDefaults.set(data, forKey: "todolist")
            userDefaults.synchronize()
        }
    }
    
    @IBOutlet weak var toDoListTableView: UITableView!
}

extension MainListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ToDoCell.heightForRow
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ToDoCell.self, for: indexPath)
        let todo = self.todoList[indexPath.row]
        cell.toDoLabel.text = todo.todoTitle
        if todo.todoDone {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todo = self.todoList[indexPath.row]
        if todo.todoDone {
            todo.todoDone = false
        } else {
            todo.todoDone = true
        }
        tableView.reloadRows(at: [indexPath], with: .fade)
        self.saveToUserDefaultsWithTodolist()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.todoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.saveToUserDefaultsWithTodolist()
        }
    }
}

final class ToDoCell: UITableViewCell {
    static let heightForRow: CGFloat = 50
    @IBOutlet weak var toDoLabel: UILabel!
}

class Todo: NSObject, NSCoding {
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.todoTitle, forKey: "todotitle")
        aCoder.encode(self.todoDone, forKey: "tododone")
    }
    
    required init?(coder aDecoder: NSCoder) {
        todoTitle = aDecoder.decodeObject(forKey: "todotitle") as? String
        todoDone = aDecoder.decodeBool(forKey: "tododone")
    }
    
    var todoTitle: String?
    var todoDone: Bool = false
    override init() { }
}
