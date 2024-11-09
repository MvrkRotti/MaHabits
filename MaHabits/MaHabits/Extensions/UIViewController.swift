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
}
