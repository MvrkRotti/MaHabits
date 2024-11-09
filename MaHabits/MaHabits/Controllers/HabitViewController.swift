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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        habitList.reloadData()
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
    
    @objc func addTapped() {
        let addVC = AddHabitController(viewModel: viewModel)
        addVC.onDismiss = { [weak self] in
            self?.habitList.reloadData()
        }
        
        addVC.modalPresentationStyle = .pageSheet
        if let sheet = addVC.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
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
        navigationController?.pushViewController(progressVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteHabit(at: indexPath.row)
            habitList.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
