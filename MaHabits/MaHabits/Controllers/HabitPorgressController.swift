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
    private let completionButton = UIButton()
    
    var buttonId: String = ""
    
    private let userDefaults = UserDefaults.standard
    
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
        updateButtonState()
    }
}

private extension HabitPorgressController {
    func setupTitleLabel() {
        titleLabel.text = "Прогресс: \n \(habit.name)"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func setupProgressLabel() {
        progressLabel.font = UIFont.systemFont(ofSize: 22)
        progressLabel.text = "Вы придерживаетесь этой привычки уже \(habit.completionCount) дней"
        progressLabel.textAlignment = .center
        progressLabel.numberOfLines = 0
        
        view.addSubview(progressLabel)
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(35)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(30)
        }
    }
    
    func setupCompleteButton() {
        completionButton.setTitle("Выполнил", for: .normal)
        completionButton.setTitleColor(.black, for: .normal)
        completionButton.layer.cornerRadius = 15
        completionButton.addTarget(self, action: #selector(completeTapped), for: .touchUpInside)
        
        view.addSubview(completionButton)
        
        completionButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.bounds.width / 2)
            make.height.equalTo(40)
        }
    }
    
    private func updateProgress() {
        progressLabel.text = "Вы придерживаетесь этой привычки уже \(daysString(for: habit.completionCount))"
    }
    
    @objc func completeTapped() {
        completionButton.isEnabled = false
        completionButton.backgroundColor = .gray
        
        let now = Date()
        userDefaults.set(now, forKey: "\(buttonId)lastTapDate")
        
        viewModel.incrementCompletionCount(for: habit)
        updateProgress()
    }
    
    private func updateButtonState() {
        let key = "\(buttonId)lastTapDate"
        if let lastTapDae = userDefaults.object(forKey: key) as? Date {
            let startOfNextDay = Calendar.current.startOfDay(for: lastTapDae.addingTimeInterval(24 * 60 * 60))
            
            if Date() >= startOfNextDay {
                completionButton.isEnabled = true
                completionButton.backgroundColor = .systemGreen
            } else {
                completionButton.isEnabled = false
                completionButton.backgroundColor = .gray
            }
        } else {
            completionButton.isEnabled = true
            completionButton.backgroundColor = .systemGreen
        }
    }
}

extension HabitPorgressController {
    private func daysString(for days: Int) -> String {
        let lastDigit = days % 10
        let lastTwoDigits = days % 100
        
        if lastTwoDigits >= 11 && lastTwoDigits <= 14 {
            return "\(days) дней"
        } else if lastDigit == 1 || days == 1 {
            return "\(days) день"
        } else if lastDigit >= 2 && lastDigit <= 4 {
            return "\(days) дня"
        } else {
            return "\(days) дней"
        }
    }
}
