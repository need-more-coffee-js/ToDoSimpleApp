//
//  TaskCell.swift
//  ToDoMVVM
//
//  Created by Денис Ефименков on 06.03.2025.
//

import UIKit
import SnapKit

class TaskCell: UITableViewCell {
    static let reuseIdentifier = "TaskCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private let isCompletedSwitch: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = .systemBlue
        return switchControl
    }()
    
    // Замыкание для обработки изменения состояния переключателя
    var switchValueChanged: ((Bool) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupSwitchAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(isCompletedSwitch)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
        
        isCompletedSwitch.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    private func setupSwitchAction() {
        // Добавляем действие для переключателя
        isCompletedSwitch.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
    }
    
    @objc private func switchChanged(_ sender: UISwitch) {
        // Вызываем замыкание при изменении состояния переключателя
        switchValueChanged?(sender.isOn)
    }
    
    func configure(with task: Task) {
        titleLabel.text = task.title
        isCompletedSwitch.isOn = task.isCompleted
    }
}
