//
//  SecondViewController.swift
//  BookmarkUI
//
//  Created by Nursat Sakyshev on 03.05.2023.
//

import UIKit

class SecondViewController: UIViewController {
    let mainLabel = UILabel()
    let label = UILabel()
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        label.text = "Bookmark App"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 56)
        ])
        
        mainLabel.text = "Save your first\nbookmark"
        mainLabel.textColor = .black
        mainLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        mainLabel.center = view.center
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 0
        view.addSubview(mainLabel)
        
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        button.setTitle("Add bookmark", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 16
        button.backgroundColor = .black
        button.addAction(.init(handler: { _ in
            self.buttonDidPress()
        }), for: .touchUpInside)
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 358),
            button.heightAnchor.constraint(equalToConstant: 58)
        ])
    }
    
    func buttonDidPress() {
        //        button.titleLabel?.alpha = 0.5
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
        //            self.button.titleLabel?.alpha = 1.0
        //        }
        
        UIView.animate(withDuration: 0.5,
                       animations: {
            self.button.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.5) {
                self.button.transform = CGAffineTransform.identity
            }
        })
        
        let alertController = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
        
        alertController.addTextField() { (textField) in
            textField.placeholder = "Bookmark title"
        }
        alertController.addTextField() { (textField) in
            textField.placeholder = "Bookmark link"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let createAction = UIAlertAction(title: "Save", style: .default)
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        present(alertController, animated: true)
    }
}
