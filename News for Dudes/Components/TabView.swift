//
//  TabView.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-09.
//

import UIKit

public class TabView: UIView {

    let titleLabel = UILabel()

    public var active: Bool = false {
        didSet {
            backgroundColor = active ? .systemBlue : .systemGray5
            titleLabel.textColor = active ? .white : .black
        }
    }

    public var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center

        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        backgroundColor = .systemGray5
        layer.cornerRadius = 12
        clipsToBounds = true
    }
}

