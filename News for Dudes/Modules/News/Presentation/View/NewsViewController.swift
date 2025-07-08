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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBind()
        viewModel?.getNews()
    }

}


private extension NewsViewController {
    func setupBind(){
        viewModel?.$news
            .receive(on: DispatchQueue.main)
            .sink{ news in
                print(news.first?.author as Any)
            }
            .store(in: &subscriptions)
    }
}
