//
//  ViewController.swift
//  BookmarkUI
//
//  Created by Nursat Sakyshev on 03.05.2023.
//

import UIKit

class ViewController: UIViewController {
    var label: UILabel!
    let image = UIImageView(image: UIImage(named: "image"))
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(image)
        
        button.setTitle("Let’s start collecting", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.layer.cornerRadius = 16
        button.backgroundColor = .white
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            button.widthAnchor.constraint(equalToConstant: 358),
            button.heightAnchor.constraint(equalToConstant: 58)
        ])
        
        label = UILabel()
        label.text = "Save all interesting\nlinks in one app"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = UIColor.white
        label.textAlignment = .left
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: button.leftAnchor),
            label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -24),
            label.widthAnchor.constraint(equalToConstant: 358),
            label.heightAnchor.constraint(equalToConstant: 92)
        ])
    }
}
