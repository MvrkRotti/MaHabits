//
//  HabitPorgressController.swift
//  MaHabits
//
//  Created by Danil Pestov on 12.10.2024.
//

import UIKit


final class HabitPorgressController: UIViewController {
    private let viewModel: HabitViewModel
    private let habit: Habit
    private let titleLabel = UILabel()
    private let progressLabel = UILabel()
    private let completionButton = UIButton(type: .system)
    
    init(viewModel: HabitViewModel, habit: Habit) {
        self.viewModel = viewModel
        self.habit = habit
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupTitleLabel()
        setupProgressLabel()
        setupCompleteButton()
    }
}

private extension HabitPorgressController {
    func setupTitleLabel() {
        titleLabel.text = "Progress for \(habit.name)"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupProgressLabel() {
        progressLabel.font = UIFont.systemFont(ofSize: 18)
        progressLabel.text = "Вы придерживаетесь этой привычки уже \(habit.completionCount) дней"
        progressLabel.textAlignment = .center
        
        view.addSubview(progressLabel)
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupCompleteButton() {
        completionButton.setTitle("Complete day", for: .normal)
        completionButton.addTarget(self, action: #selector(completeTapped), for: .touchUpInside)
        
        view.addSubview(completionButton)
        
        completionButton.snp.makeConstraints { make in
            make.top.equalTo(progressLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func updateProgress() {
        progressLabel.text = "Вы придерживаетесь этой привычки уже \(habit.completionCount) дней"
    }
    
    @objc func completeTapped() {
        viewModel.incrementCompletionCount(for: habit)
        updateProgress()
    }
}
