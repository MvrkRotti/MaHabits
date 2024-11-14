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
        view.backgroundColor = #colorLiteral(red: 0.9623396993, green: 0.8826696277, blue: 0.772307992, alpha: 1)
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.numberOfLines = 1
        return label
    }()
    
    private let daysLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 1
        return label
    }()
    
    //Добавить progress bar
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        backgroundColor = .clear
        setupShadows()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        backgroundColor = .clear
        setupShadows()
    }
    
    func configureCell(with title: String, days: Int) {
        titleLabel.text = title
        daysLabel.text = "🔥\(days)"
    }
}

private extension HabitCell {
    func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(daysLabel)
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.left.equalToSuperview().offset(20)
        }
        
        daysLabel.snp.makeConstraints { make in
            make.centerY.equalTo(containerView)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    func setupShadows() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
        
        backgroundColor = .clear
    }
}
