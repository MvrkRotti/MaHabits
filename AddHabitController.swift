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
    private let descriptionLabel = UILabel()
    private let saveButton = UIButton()
    
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
        setupDescrLabel()
        setupTextField()
        setupSaveButton()
    }
}

private extension AddHabitController {
    func setupTextField() {
        titleTextField.placeholder = "Название"
        titleTextField.borderStyle = .roundedRect
        
        view.addSubview(titleTextField)
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(25)
        }
    }
    
    func setupDescrLabel() {
        descriptionLabel.text = "Test, test, test, test, test, test, test, test, test, test, test, test, test, test, test, test, test, test, test"
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont.systemFont(ofSize: 20)
        descriptionLabel.textAlignment = .center
        
        view.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(40)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func setupSaveButton() {
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 15
        saveButton.backgroundColor = .systemBlue
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(view.bounds.width / 2)
            make.height.equalTo(40)
        }
    }
    
    @objc func saveTapped() {
        guard let name = titleTextField.text, !name.isEmpty else { return }
        viewModel.addHabbit(name: name)
        onDismiss?()
        dismiss(animated: true)
    }
}
