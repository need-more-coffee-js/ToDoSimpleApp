//
//  TaskService.swift
//  ToDoMVVM
//
//  Created by Денис Ефименков on 19.02.2025.
//

import Foundation

struct Task {
    let id: Int
    let title: String
}

class TaskService {
    func fetchTasks(completion: @escaping ([Task]) -> Void) {
        // Имитация асинхронной загрузки данных
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            let tasks = [
                Task(id: 1, title: "Купить продукты"),
                Task(id: 2, title: "Выучить MVVM"),
                Task(id: 3, title: "Сделать зарядку")
            ]
            completion(tasks)
        }
    }
}
