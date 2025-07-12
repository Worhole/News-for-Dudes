//
//  ViewController.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
    
    private var subscriptions = Set<AnyCancellable>()
    var viewModel:NewsViewModel?
    
    var categorySelector = CategorySelector()
    let categoryTitles = ["General", "Entertainment", "Business", "Health", "Science", "Sports","Technology"]
    
    lazy var newsTableView:UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseId)
        return $0
    }(UITableView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBind()
        setupCategorySelectorSettings()
        setupLayout()
    }
}

private extension NewsViewController {
    func setupBind(){
        viewModel?.$news
            .receive(on: DispatchQueue.main)
            .sink{_ in 
                self.newsTableView.reloadData()
            }
            .store(in: &subscriptions)
    }
}

private extension NewsViewController {
    func setupLayout(){
        view.backgroundColor = .white
        
        view.addSubview(newsTableView)
        NSLayoutConstraint.activate([
            newsTableView.topAnchor.constraint(equalTo: categorySelector.bottomAnchor,constant: 12),
            newsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

private extension NewsViewController {
    func setupCategorySelectorSettings(){
        var tabViews = [TabView]()
        for title in categoryTitles {
            let tab = TabView()
            tab.title = title
            tab.translatesAutoresizingMaskIntoConstraints = false
            tabViews.append(tab)
        }
        categorySelector.delegate = self
        categorySelector.translatesAutoresizingMaskIntoConstraints = false
        categorySelector.setup(tabs: tabViews, selectedIndex: 0)
        
        view.addSubview(categorySelector)

        NSLayoutConstraint.activate([
            categorySelector.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categorySelector.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categorySelector.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categorySelector.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

// MARK: -- CategorySelectorDelegate
extension NewsViewController:CategorySelectorDelegate {
    func scrollableTabView(_ tabView: CategorySelector, didTapAt index: Int) {
        switch index {
        case 0:
            viewModel?.getNews(category: .general)
        case 1:
            viewModel?.getNews(category: .entertainment)
        case 2:
            viewModel?.getNews(category: .business)
        case 3:
            viewModel?.getNews(category: .health)
        case 4:
            viewModel?.getNews(category: .science)
        case 5:
            viewModel?.getNews(category: .sports)
        case 6:
            viewModel?.getNews(category: .technology)
        default:
            break
        }
    }
}

// MARK: -- UITableViewDelegate

extension NewsViewController:UITableViewDelegate {
    
}

// MARK: -- UITableViewDataSource
extension NewsViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.news.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseId) as! NewsTableViewCell
        
        cell.configue(title: viewModel?.news[indexPath.row].title,
                      description: viewModel?.news[indexPath.row].description,
                      source: viewModel?.news[indexPath.row].author)
        
        return cell
    }
}
