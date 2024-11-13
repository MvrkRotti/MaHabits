//
//  HabitCell.swift
//  MaHabits
//
//  Created by Danil Pestov on 13.11.2024.
//

import UIKit
import SnapKit

final class HabitCell: UITableViewCell {
    
    static let identifier  = "HabitCell"
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    //Добавить progress bar
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func configureCell(with title: String) {
        titleLabel.text = title
    }
}

private extension HabitCell {
    func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(10)
        }
    }
}
