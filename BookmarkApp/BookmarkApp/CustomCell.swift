//
//  CustomCell.swift
//  BookmarkApp
//
//  Created by Nursat Sakyshev on 24.04.2024.
//

import UIKit


class CustomCell: UITableViewCell {
    let date = UILabel()
    let name = UILabel()
    let linkImage = UIImageView()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setupUI() {
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

