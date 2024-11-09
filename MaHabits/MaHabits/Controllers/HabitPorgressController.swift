//
//  HabitPorgressController.swift
//  MaHabits
//
//  Created by Danil Pestov on 12.10.2024.
//

import UIKit


final class HabitPorgressController: UIViewController {
//    private let habit: HabitEntity
    private let viewModel: HabitViewModel
    private let titleLabel = UILabel()
    private let progressLabel = UILabel()
    private let completionButton = UIButton(type: .system)
    
    init(/*habit: HabitEntity,*/ viewModel: HabitViewModel) {
//        self.habit = habit
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .pageSheet
        isModalInPresentation = true
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
//        updateProgress()
        
        if let sheet = self.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
    }
}

private extension HabitPorgressController {
    func setupTitleLabel() {
//        titleLabel.text = "Progress for \(habit.title ?? "Habit")"
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
        progressLabel.textAlignment = .center
        
        view.addSubview(progressLabel)
        
        progressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupCompleteButton() {
        completionButton.setTitle("Complete day", for: .normal)
//        completionButton.addTarget(self, action: #selector(completeTapped), for: .touchUpInside)
    }
    
//    private func updateProgress() {
//        let daysCompleted = habit.completionCount
//        progressLabel.text = "Completed \(daysCompleted) times"
//    }
//    
//    @objc func completeTapped() {
//        viewModel.completeHabit(habit)
//        updateProgress()
//    }
}
