//
//  ViewController.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-08.
//

import UIKit
import Combine

class NewsViewController: UIViewController {
    
    var viewModel:NewsViewModel?
    
    var categorySelector = CategorySelector()
    let categoryTitles = ["General", "Entertainment", "Business", "Health", "Science", "Sports","Technology"]
    
    lazy var newsTableView:UITableView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.dataSource = self
        $0.delegate = self
        $0.showsVerticalScrollIndicator = false
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
        viewModel?.news.bind({ [weak self] _ in
            guard let self = self else {return}
            self.newsTableView.reloadData()
        })
    }
}

private extension NewsViewController {
    func setupLayout(){
        view.backgroundColor = .systemBackground
        
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = viewModel?.news.value[indexPath.row] else{
            print("ошибка данных: news = nil")
            return}
        let vc = NewsDetailModuleBuilder.build(data: news.toDisplayModel(), mode: .networkNews, close: {})
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: -- UITableViewDataSource
extension NewsViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.news.value.count ?? 0
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseId) as! NewsTableViewCell
        
        cell.configue(title: viewModel?.news.value[indexPath.row].title,
                      description: viewModel?.news.value[indexPath.row].description,
                      source: viewModel?.news.value[indexPath.row].source.name)
        return cell
    }
}
