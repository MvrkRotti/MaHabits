//
//  ViewController.swift
//  MaHabits
//
//  Created by Danil Pestov on 12.10.2024.
//

import UIKit
import SnapKit

class HabitViewController: UIViewController {
    
    //MARK: - Variables
    private let viewModel = HabitViewModel()
    private let habitList = UITableView()
    private let phraseLabel = UILabel()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupNavBar()
        setupPhraseLabel()
        checkData()
        addNavigationBarSeparator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitList.reloadData()
        checkData()
    }
}

//MARK: - UI Setup extension
private extension HabitViewController {
    func setupTableView() {
        view.addSubview(habitList)
        habitList.translatesAutoresizingMaskIntoConstraints = false
        
        habitList.delegate = self
        habitList.dataSource = self
        habitList.register(UITableViewCell.self, forCellReuseIdentifier: "HabitCell")
        
        habitList.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupNavBar() {
        title = "Привычки"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    }
    
    func setupPhraseLabel() {
        phraseLabel.isHidden = true
        phraseLabel.text = "\"Сильные привычки формируют сильную личность. Начни с малого - и ты удивишься, как делеко можешь зайти!\""
        phraseLabel.font = UIFont.systemFont(ofSize: 18)
        phraseLabel.textColor = .lightGray
        phraseLabel.numberOfLines = 0
        phraseLabel.textAlignment = .center
        
        view.addSubview(phraseLabel)
        
        phraseLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
    }
    
    func checkData() {
        if viewModel.habits.isEmpty {
            phraseLabel.isHidden = false
            habitList.isHidden = true
        } else {
            habitList.isHidden = false
            phraseLabel.isHidden = true
        }
    }
    
    @objc func addTapped() {
        let addVC = AddHabitController(viewModel: viewModel)
        addVC.onDismiss = { [weak self] in
            self?.habitList.reloadData()
            self?.checkData()
        }
        setupMediumPresent(for: addVC)
        present(addVC, animated: true)
    }
    
    
}

//MARK: - Table view settings extension
extension HabitViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.habits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = habitList.dequeueReusableCell(withIdentifier: "HabitCell", for: indexPath)
        let habit = viewModel.habits[indexPath.row]
        cell.textLabel?.text = habit.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let habit = viewModel.habits[indexPath.row]
        let progressVC = HabitPorgressController(viewModel: viewModel, habit: habit)
        progressVC.buttonId = "button\(indexPath.row)"
        setupMediumPresent(for: progressVC)
        present(progressVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let buttonId = "button\(indexPath.row)"
            
            UserDefaults.standard.removeObject(forKey: "\(buttonId)lastTapDate")
            
            viewModel.deleteHabit(at: indexPath.row)
            habitList.deleteRows(at: [indexPath], with: .automatic)
            checkData()
        }
    }
}
