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
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with task: Task) {
        titleLabel.text = task.title
    }
}
