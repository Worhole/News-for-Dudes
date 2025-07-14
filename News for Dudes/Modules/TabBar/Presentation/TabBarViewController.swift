//
//  TabBarController.swift
//  News for Dudes
//
//  Created by 71m3 on 2025-07-13.
//

import UIKit


class TabBarViewController: UITabBarController {

    let newsVC = NewsModuleBuilder.build() 
    let bookmarksVC =  BookmarksModuleBuilder.build()
    
    lazy var newsButton = getButton(icon: "globe", tag: 0, action: action,opacity: 1)
    lazy var bookmarksButton = getButton(icon: "archivebox", tag: 1, action: action)
    
    lazy var action = UIAction  { [weak self] sender in
        guard let self = self,
              let sender = sender.sender as? UIButton else {return}
        self.selectedIndex = sender.tag
        self.setOpacity(tag: sender.tag)
    }
    
    lazy var customBar:UIStackView = {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.backgroundColor = .secondarySystemBackground
        $0.frame = CGRect(x: 80, y: view.bounds.height - 100, width: view.bounds.width - 160, height: 50)
        $0.layer.cornerRadius = 25
        
        $0.layer.shadowColor = UIColor.tertiaryLabel.cgColor
        $0.layer.shadowOpacity = 0.5
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 10
        $0.layer.masksToBounds = false
        
        $0.addArrangedSubview(UIView())
        $0.addArrangedSubview(newsButton)
        $0.addArrangedSubview(bookmarksButton)
        $0.addArrangedSubview(UIView())
    
        return $0
    }(UIStackView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setViewControllers([newsVC,bookmarksVC], animated: true)
    }

}

private extension TabBarViewController {
    func setupLayout(){
        view.addSubview(customBar)
        tabBar.isHidden = true
    }
    
    func getButton(icon:String,tag:Int,action:UIAction,opacity:Float = 0.5) -> UIButton {
        return {
            $0.setImage(UIImage(systemName: icon), for: .normal)
            $0.tintColor = .label
            $0.layer.opacity = opacity
            $0.tag = tag
            return $0
        }(UIButton(primaryAction: action))
    }
    
    func setOpacity(tag:Int){
        [newsButton,bookmarksButton].forEach { button in
            if button.tag != tag {
                button.layer.opacity = 0.5
            } else {
                button.layer.opacity = 1
            }
        }
    }
}
