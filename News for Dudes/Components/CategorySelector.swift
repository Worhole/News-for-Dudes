//
//  CategorySelector.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-09.
//

import UIKit

public protocol CategorySelectorDelegate: AnyObject {
    func scrollableTabView(_ tabView: CategorySelector, didTapAt index: Int)
}

public class CategorySelector: UIView {

    let scrollView = UIScrollView()
    var tabs = [TabView]()

    weak var delegate: CategorySelectorDelegate?

    public func setup(tabs: [TabView], selectedIndex: Int) {
        for view in scrollView.subviews {
            view.removeFromSuperview()
        }
        self.tabs = tabs
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        var previousTab: UIView?

        for tab in tabs {
            tab.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview(tab)

            let tap = UITapGestureRecognizer(target: self, action: #selector(tabTapped))
            tab.addGestureRecognizer(tap)

            NSLayoutConstraint.activate([
                tab.topAnchor.constraint(equalTo: scrollView.topAnchor),
                tab.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
                tab.heightAnchor.constraint(equalToConstant: 44)
            ])

            if let prev = previousTab {
                NSLayoutConstraint.activate([
                    tab.leadingAnchor.constraint(equalTo: prev.trailingAnchor, constant: 12)
                ])
            } else {
                NSLayoutConstraint.activate([
                    tab.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 12)
                ])
            }

            previousTab = tab
        }

        if let last = previousTab {
            last.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -12).isActive = true
        }
        select(selectedIndex)
    }

    @objc
    func tabTapped(_ recognizer: UITapGestureRecognizer) {
        guard let tabView = recognizer.view as? TabView,
              let index = tabs.firstIndex(of: tabView) else { return }

        select(index)
    }

    func select(_ tabIndex: Int, animated: Bool = true) {
        for tab in tabs {
            tab.active = false
        }
        let selectedTab = tabs[tabIndex]
        selectedTab.active = true
      
        if tabIndex != 0 {
            animateSelectedTabToCenter(selectedTab)
        } else {
            scrollView.setContentOffset(.zero, animated: false)
        }

        delegate?.scrollableTabView(self, didTapAt: tabIndex)
    }

    func animateSelectedTabToCenter(_ selectedTab: TabView) {
        layoutIfNeeded()

        let potentialOffset = selectedTab.frame.midX - scrollView.bounds.width / 2
        let maxOffset = scrollView.contentSize.width - scrollView.bounds.width
        let offset = max(0, min(potentialOffset, maxOffset))
     
        scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
}



