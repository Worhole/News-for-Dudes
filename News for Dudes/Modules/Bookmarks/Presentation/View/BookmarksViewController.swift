//
//  BookmarksViewController.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-13.
//

import UIKit
import Combine

class BookmarksViewController: UIViewController {

    var viewModel:BookmarksViewModel?
    private var subscriptions = Set<AnyCancellable>()
    
    lazy var bookmarksTableView:UITableView = {
        $0.dataSource = self
        $0.delegate = self
        $0.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.reuseId)
        $0.showsVerticalScrollIndicator = false           
        
        return $0
    }(UITableView(frame: view.bounds))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        view.addSubview(bookmarksTableView)
        setupBind()
        viewModel?.fetchBookmarks()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
         navigationController?.navigationBar.shadowImage = UIImage()
         navigationController?.navigationBar.isTranslucent = true
         navigationController?.navigationBar.backgroundColor = .clear


    }

}

private extension BookmarksViewController {
    func setupBind(){
        viewModel?.$bookmarks
            .receive(on: DispatchQueue.main)
            .sink{_ in
                self.bookmarksTableView.reloadData()
            }
            .store(in: &subscriptions)
    }
}

extension BookmarksViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let news = viewModel?.bookmarks[indexPath.row] else{
            print("ошибка данных: news = nil")
            return}
        let vc = NewsDetailModuleBuilder.build(data: news.toDisplayModel(), mode: .bookmarks, close: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        })
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension BookmarksViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.bookmarks.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseId) as! NewsTableViewCell
        
        cell.configue(title: viewModel?.bookmarks[indexPath.row].title,
                      description: viewModel?.bookmarks[indexPath.row].newsDescription,
                      source: viewModel?.bookmarks[indexPath.row].source)
        return cell
    }
}

