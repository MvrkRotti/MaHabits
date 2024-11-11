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
    private let titleLabel = UILabel()
    private let saveButton = UIButton()
    private let infoLabel = UILabel()
    
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
        setupInfoLabel()
        setupSaveButton()
    }
}

private extension AddHabitController {
    
    func setupDescrLabel() {
        titleLabel.text = "Начни с малого! \n Добавь привычку и становись немного лучше. Укажи название в поле снизу"
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        titleLabel.textAlignment = .center
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.bounds.height / 21)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func setupTextField() {
        titleTextField.placeholder = "Название"
        titleTextField.borderStyle = .roundedRect
        
        view.addSubview(titleTextField)
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(view.bounds.height / 35)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(25)
        }
    }
    
    func setupInfoLabel() {
        infoLabel.text = "Укажите название максимально понятно и лаконично, без лишних подробностей. Название не должно превышать 15 символов."
        infoLabel.numberOfLines = 0
        infoLabel.font = UIFont.systemFont(ofSize: 15)
        infoLabel.textAlignment = .center
        infoLabel.textColor = .lightGray
        
        view.addSubview(infoLabel)
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom).inset(-view.bounds.height / 35)
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
        guard let name = titleTextField.text, !name.isEmpty, name.count < 15 else { return }
        viewModel.addHabbit(name: name)
        onDismiss?()
        dismiss(animated: true)
    }
}
