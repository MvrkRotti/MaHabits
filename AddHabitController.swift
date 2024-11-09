//
//  AddHabitController.swift
//  MaHabits
//
//  Created by Danil Pestov on 12.10.2024.
//

import Foundation
import UIKit

final class AddHabitController: UIViewController {
    private let viewModel: HabitViewModel
    
    private let titleTextField = UITextField()
    private let saveButton = UIButton(type: .system)
    
    var onDismiss: (() -> Void)?
    
    init(viewModel: HabitViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTextField()
        setupSaveButton()
    }
}

private extension AddHabitController {
    func setupTextField() {
        titleTextField.placeholder = "Введите название привычки"
        titleTextField.borderStyle = .roundedRect
        
        view.addSubview(titleTextField)
        
        titleTextField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func setupSaveButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.centerX.equalToSuperview()
        }
    }
    
    @objc func saveTapped() {
        guard let name = titleTextField.text, !name.isEmpty else { return }
        viewModel.addHabbit(name: name)
        onDismiss?()
        dismiss(animated: true)
    }
}
