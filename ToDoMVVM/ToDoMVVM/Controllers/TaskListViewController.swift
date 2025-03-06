//
//  TaskListViewController.swift
//  ToDoMVVM
//
//  Created by Денис Ефименков on 19.02.2025.
//

import UIKit

class TaskListViewController: UIViewController {
    
    private let viewModel = TaskViewModel()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TaskCell.self, forCellReuseIdentifier: TaskCell.reuseIdentifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupNavigationBar()
        
        // Загрузка задач
        viewModel.fetchTasks()
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "To-Do List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
    }
    
    @objc private func addTask() {
        let alert = UIAlertController(title: "Новая задача", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Введите задачу"
        }
        alert.addAction(UIAlertAction(title: "Добавить", style: .default, handler: { [weak self] _ in
            guard let self = self, let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            self.viewModel.addTask(title: text)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
}

extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfTasks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskCell.reuseIdentifier, for: indexPath) as! TaskCell
        let task = viewModel.task(at: indexPath.row)
        cell.configure(with: task)
        
        // Обработка изменения состояния переключателя
        cell.switchValueChanged = { [weak self] isOn in
            guard let self = self else { return }
            self.viewModel.toggleTaskCompletion(at: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeTask(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = viewModel.task(at: indexPath.row)
        let alert = UIAlertController(title: "Редактировать задачу", message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = task.title
        }
        alert.addAction(UIAlertAction(title: "Сохранить", style: .default, handler: { [weak self] _ in
            guard let self = self, let text = alert.textFields?.first?.text, !text.isEmpty else { return }
            self.viewModel.updateTask(at: indexPath.row, newTitle: text)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }))
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
}
