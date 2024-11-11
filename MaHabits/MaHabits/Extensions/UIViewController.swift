//
//  UIViewController.swift
//  MaHabits
//
//  Created by Danil Pestov on 09.11.2024.
//

import UIKit

extension UIViewController {
    func setupMediumPresent(for screen: UIViewController) {
        screen.modalPresentationStyle = .pageSheet
        if let sheet = screen.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
    }
    
    func addNavigationBarSeparator(color: UIColor = .lightGray, height: CGFloat = 1) {
            let navigationBarSeparator = UIView()
            navigationBarSeparator.translatesAutoresizingMaskIntoConstraints = false
            navigationBarSeparator.backgroundColor = color
            view.addSubview(navigationBarSeparator)
            
            NSLayoutConstraint.activate([
                navigationBarSeparator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                navigationBarSeparator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                navigationBarSeparator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                navigationBarSeparator.heightAnchor.constraint(equalToConstant: height)
            ])
        }
}
