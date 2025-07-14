//
//  NewsDetailViewController.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-12.
//

import UIKit
import Combine


class NewsDetailViewController: UIViewController {
    
    private var subscriptions = Set<AnyCancellable>()
    var viewModel:NewsDetailViewModel?

    lazy var content:UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    lazy var contentScroll:UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
        $0.addSubview(content)
        return $0
    }(UIScrollView(frame: view.frame))
    
    lazy var barButton:UIButton = {
        $0.setTitle(viewModel!.isSaved ? "Delete" : "Save", for: .normal)
        $0.backgroundColor = viewModel!.isSaved ? #colorLiteral(red: 1, green: 0.2153770328, blue: 0.3606185019, alpha: 1) : #colorLiteral(red: 0.09206429869, green: 0.4222652912, blue: 0.9932720065, alpha: 1)
        $0.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        $0.tintColor = .white
        $0.layer.cornerRadius = 15
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        $0.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var newsImageView:UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        return $0
    }(UIImageView())
    
    lazy var sourceLabel:UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var authorLabel:UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .tertiaryLabel
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var titleLabel:UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 0
        $0.textColor = .label
        $0.font = .systemFont(ofSize: 25, weight: .heavy)
        return $0
    }(UILabel())

    lazy var descriptionLabel:UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var dateLabel:UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .tertiaryLabel
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    lazy var contentLabel:UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .label
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.getNews()
        setupBind()
        setupLayout()
    }
}

private extension NewsDetailViewController {
    func setupBind(){
        viewModel?.$viewData
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { data in
                self.setData(data: data)
            })
            .store(in: &subscriptions)
        
        viewModel?.$isSaved
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.updateBarButton()
            }
            .store(in: &subscriptions)

    }
}

private extension NewsDetailViewController {
    
    func setData(data:NewsDetailViewData?){
        titleLabel.text = data?.title
        setImage(urlStr: data?.imageUrl, imageView: newsImageView, width: UIScreen.main.bounds.width - 24)
        authorLabel.text = data?.author
        dateLabel.text = data?.date
        sourceLabel.text = data?.source
        descriptionLabel.text = data?.description
        contentLabel.text = data?.content
    }
    
    func setImage(urlStr:String?,imageView: UIImageView, width: CGFloat){
        guard let urlStr = urlStr, let url = URL(string: urlStr) else {return}
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                
                let imageSize = image.size
                let aspectRatio = imageSize.height / imageSize.width
                let calculatedHeight = width * aspectRatio
                
                DispatchQueue.main.async {
                    imageView.image = image
                    imageView.heightAnchor.constraint(equalToConstant: calculatedHeight).isActive = true
                   
                }
            }
        }
    }
}

private extension NewsDetailViewController {
    func setupLayout(){
        
        view.addSubview(contentScroll)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: barButton)

        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: contentScroll.topAnchor),
            content.leadingAnchor.constraint(equalTo: contentScroll.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: contentScroll.trailingAnchor),
            content.bottomAnchor.constraint(equalTo: contentScroll.bottomAnchor),
            content.widthAnchor.constraint(equalTo: contentScroll.widthAnchor)])
        
        view.backgroundColor = .systemBackground
        
        content.addSubview(titleLabel)
        content.addSubview(newsImageView)
        content.addSubview(descriptionLabel)
        content.addSubview(authorLabel)
        content.addSubview(dateLabel)
        content.addSubview(sourceLabel)
        content.addSubview(contentLabel)
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: content.safeAreaLayoutGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -12),
            
            sourceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            sourceLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor,constant: 12),
            sourceLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -12),
            
            dateLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 12),
            dateLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor,constant: 12),
            dateLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -12),
            
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor,constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -12),
            
            newsImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            newsImageView.leadingAnchor.constraint(equalTo: content.leadingAnchor,constant: 12),
            newsImageView.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -12),
           
            
            authorLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 12),
            authorLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor,constant: 12),
            authorLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -12),
            
            contentLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            contentLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor,constant: 12),
            contentLabel.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -12),
            contentLabel.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -50)
            
        ])
    }
}

private extension NewsDetailViewController {
    func updateBarButton(){
        guard let button = navigationItem.rightBarButtonItem?.customView as? UIButton else { return }
        let isSaved = viewModel?.isSaved ?? false
        button.setTitle(isSaved ? "Delete" : "Save", for: .normal)
        button.backgroundColor = viewModel!.isSaved ? #colorLiteral(red: 1, green: 0.2153770328, blue: 0.3606185019, alpha: 1) : #colorLiteral(red: 0.09206429869, green: 0.4222652912, blue: 0.9932720065, alpha: 1)
    }
    @objc
    func buttonTapped(){
        viewModel?.buttonTapped()
    }
}
