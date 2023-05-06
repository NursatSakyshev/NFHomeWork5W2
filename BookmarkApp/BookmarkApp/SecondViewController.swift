//
//  SecondViewController.swift
//  BookmarkUI
//
//  Created by Nursat Sakyshev on 03.05.2023.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDataSource {
    
    let mainLabel = UILabel()
    let label = UILabel()
    let button = UIButton()
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "Bookmark App"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 56)
        ])
        
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.rowHeight = 74
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

//        mainLabel.text = "Save your first\nbookmark"
//        mainLabel.textColor = .black
//        mainLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
//        mainLabel.center = view.center
//        mainLabel.textAlignment = .center
//        mainLabel.numberOfLines = 0
//        view.addSubview(mainLabel)
        
//        mainLabel.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//        ])

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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        let bookmark = bookmarks[indexPath.row]
        cell.name.text = bookmark.name
        cell.linkImage.image = UIImage(named: "link")
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
        let createAction = UIAlertAction(title: "Save", style: .cancel) {_ in
            let bookmarkName = alertController.textFields![0].text
            let bookmarkLink = alertController.textFields![1].text
            
            if bookmarkName != "" && bookmarkLink != "" {
                addBookmark(name: bookmarkName!, link: bookmarkLink!)
                self.tableView.reloadData()
            }
            else {
                let requiredText = UIAlertController(title: "Write bookmark correctly", message: nil, preferredStyle: .alert)
                let enterText = UIAlertAction(title: "OK", style: .default)
                requiredText.addAction(enterText)
                self.present(requiredText, animated: true)
            }
        }
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        present(alertController, animated: true)
    }
}

class CustomCell: UITableViewCell {
    let name = UILabel()
    let linkImage = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(name)
        addSubview(linkImage)
        
        [name, linkImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 39),
            name.widthAnchor.constraint(equalToConstant: 326),
            name.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        NSLayoutConstraint.activate([
            linkImage.leftAnchor.constraint(equalTo: name.rightAnchor, constant: 11),
            linkImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 42),
            linkImage.widthAnchor.constraint(equalToConstant: 18),
            linkImage.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//extension ViewController: UITableViewDelegate, UITableViewDataSource {
////    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return 5
////    }
////
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//////        let cell = tableView.dequeueReusableCell(withIdentifier: "CellIdentifier", for: indexPath)
////        let cell =
////        cell.textLabel?.text = "hello"
////        return cell
////    }
////
////    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        tableView.deselectRow(at: indexPath, animated: true)
////        print(bookmarks[indexPath.row])
////    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//        cell.textLabel?.text = "Row \(indexPath.row + 1)"
//        return cell
//    }
//}
