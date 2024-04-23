//
//  SecondViewController.swift
//  BookmarkUI
//
//  Created by Nursat Sakyshev on 03.05.2023.
//

import UIKit
import SafariServices

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let mainLabel = UILabel()
    let label = UILabel()
    let button = UIButton()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationItem.hidesBackButton = true
    }
    
    func setupUI() {
        label.text = bookmarks.isEmpty ? "Bookmark App" : "List"
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
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
        
        mainLabel.text = "Save your first\nbookmark"
        mainLabel.textColor = .black
        mainLabel.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        mainLabel.center = view.center
        mainLabel.textAlignment = .center
        mainLabel.numberOfLines = 0
        mainLabel.isHidden = bookmarks.isEmpty ? false : true
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        let bookmark = bookmarks[indexPath.row]
        cell.name.text = bookmark.name
        cell.linkImage.image = UIImage(named: "link")
        cell.date.text = "\(bookmark.date.displayMinAndSeconds())  \(bookmark.date.getDay())"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let url = URL(string: "https://\(bookmarks[indexPath.row].link)") else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    func buttonDidPress() {
        button.titleLabel?.alpha = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.button.titleLabel?.alpha = 1.0
        }
        AddOrChangeAlert(title: "Add", index: nil)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            removeBookmark(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            self.updateUI()
            tableView.reloadData()
        }
        
        let changeAction = UITableViewRowAction(style: .default, title: "Change") { _, indexPath in
            self.AddOrChangeAlert(title: "Change", index: indexPath.row)
        }
        
        changeAction.backgroundColor = .blue
        deleteAction.backgroundColor = .red
        return [deleteAction, changeAction]
    }
    
    func updateUI() {
        if bookmarks.isEmpty {
            label.text = "Bookmark App"
            mainLabel.isHidden = false
        }
        else {
            label.text = "List"
            mainLabel.isHidden = true
        }
    }
    
    func AddOrChangeAlert(title: String, index: Int?) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alertController.addTextField() { (textField) in
            textField.placeholder = "Bookmark title"
        }
        alertController.addTextField() { (textField) in
            textField.placeholder = "Bookmark link"
        }
        if title == "Change" {
            alertController.textFields![0].text = bookmarks[index!].name
            alertController.textFields![1].text = bookmarks[index!].link
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        let createAction = UIAlertAction(title: "Save", style: .cancel) { _ in
            
            let bookmarkName = alertController.textFields![0].text
            let bookmarkLink = alertController.textFields![1].text
            
            if bookmarkName != "" && bookmarkLink != "" {
                if title == "Add" {
                    addBookmark(name: bookmarkName!, link: bookmarkLink!, date: Date())
                }
                else {
                    bookmarks[index!].name = bookmarkName!
                    bookmarks[index!].link = bookmarkLink!
                    bookmarks[index!].date = Date()
                }
                self.tableView.reloadData()
                self.updateUI()
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
    let date = UILabel()
    let name = UILabel()
    let linkImage = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(name)
        addSubview(linkImage)
        addSubview(date)
        
        [name, linkImage, date].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        date.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        NSLayoutConstraint.activate([
            name.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            name.widthAnchor.constraint(equalToConstant: 326),
            name.heightAnchor.constraint(equalToConstant: 24),
            
            linkImage.leftAnchor.constraint(equalTo: name.rightAnchor, constant: 11),
            linkImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 42),
            linkImage.widthAnchor.constraint(equalToConstant: 18),
            linkImage.heightAnchor.constraint(equalToConstant: 18),
            
            date.topAnchor.constraint(equalTo: name.bottomAnchor,constant: 15),
            date.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            date.widthAnchor.constraint(equalToConstant: 326),
            date.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension Date {
    func displayMinAndSeconds() -> String {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let stringFormat = formatter.string(from: self)
        return stringFormat
    }
    
    func getDay() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY"
        return formatter.string(from: self)
    }
}
