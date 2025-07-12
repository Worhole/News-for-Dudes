//
//  NewsTableViewCell.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-09.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    static let reuseId = "NewsTableViewCell"
    
    lazy var titleLabel:UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 20, weight: .heavy)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var descriptionLabel:UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 13, weight: .semibold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var sourceLabel:UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .systemFont(ofSize: 13, weight: .regular)
        return $0
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        //
    }
    
}

extension NewsTableViewCell {
    func configue(title: String?, description:String?, source:String?){
        titleLabel.text = title
        descriptionLabel.text = description
        sourceLabel.text = source
    }
}

private extension NewsTableViewCell {
    func setupLayout(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(sourceLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            
            sourceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 14),
            sourceLabel.leadingAnchor.constraint(equalTo:titleLabel.leadingAnchor),
            sourceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            sourceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
    }
    
}
