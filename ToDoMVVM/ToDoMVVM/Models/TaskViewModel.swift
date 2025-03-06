//
//  TaskViewModel.swift
//  ToDoMVVM
//
//  Created by Денис Ефименков on 19.02.2025.
//
import CoreData
import UIKit

class TaskViewModel {
    private var tasks: [Task] = []
    
    // Загрузка задач из CoreData
    func fetchTasks() {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            tasks = try CoreDataManager.shared.context.fetch(request)
        } catch {
            print("Error fetching tasks: \(error)")
        }
    }
    
    // Количество задач
    var numberOfTasks: Int {
        return tasks.count
    }
    
    // Добавление задачи
    func addTask(title: String) {
        let newTask = Task(context: CoreDataManager.shared.context)
        newTask.id = UUID()
        newTask.title = title
        newTask.isCompleted = false
        tasks.append(newTask)
        CoreDataManager.shared.saveContext()
    }
    
    // Удаление задачи
    func removeTask(at index: Int) {
        let task = tasks[index]
        CoreDataManager.shared.context.delete(task)
        tasks.remove(at: index)
        CoreDataManager.shared.saveContext()
    }
    
    // Редактирование задачи
    func updateTask(at index: Int, newTitle: String) {
        let task = tasks[index]
        task.title = newTitle
        CoreDataManager.shared.saveContext()
    }
    
    // Изменение статуса задачи
    func toggleTaskCompletion(at index: Int) {
        let task = tasks[index]
        task.isCompleted.toggle()
        CoreDataManager.shared.saveContext()
    }
    
    // Получение задачи по индексу
    func task(at index: Int) -> Task {
        return tasks[index]
    }
}
