//
//  TaskViewModel.swift
//  ToDoMVVM
//
//  Created by Денис Ефименков on 19.02.2025.
//

import Foundation

class TaskViewModel {
    private let taskService: TaskService
    var tasks: [Task] = []

    // Callback для обновления View
    var onTasksUpdated: (() -> Void)?

    init(taskService: TaskService) {
        self.taskService = taskService
    }

    func loadTasks() {
        taskService.fetchTasks { [weak self] tasks in
            self?.tasks = tasks
            self?.onTasksUpdated?() // Вызываем callback после получения данных
        }
    }

    func numberOfTasks() -> Int {
        return tasks.count
    }

    func taskTitle(at index: Int) -> String {
        return tasks[index].title
    }
}
