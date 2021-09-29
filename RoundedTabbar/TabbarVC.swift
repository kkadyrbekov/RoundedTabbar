import UIKit

final class TabbarVC: UITabBarController {
    
    lazy var tabbarItems = createTabbarItems()
    lazy var customTabBar = Tabbar()
    lazy var centerTabbarView = makeCenterTabbarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var vcs: [ViewController] = []
        for _ in 0...4 {
            let vc = ViewController()
            vc.view.backgroundColor = .white
            vcs.append(vc)
        }
        viewControllers = vcs
        tabBar.isTranslucent = false
        delegate = self
        setSubviews()
    }
    
    func setSubviews() {
        customTabBar.delegate = self
        customTabBar.setItems(tabbarItems, animated: false)
        customTabBar.tintColor = .blue
        customTabBar.unselectedItemTintColor = .lightGray
        customTabBar.selectedItem = tabbarItems.first
        tabBar.addSubview(customTabBar)
        view.addSubview(centerTabbarView)
        
        customTabBar.anchor(
            .leading(view.leadingAnchor),
            .trailing(view.trailingAnchor),
            .bottom(view.bottomAnchor),
            .height(84)
        )
        
        centerTabbarView.anchor(
            .centerX(view.centerXAnchor),
            .bottom(view.bottomAnchor, constant: 30),
            .height(80),
            .width(80)
        )
    }
    
    func createTabbarItems() -> [UITabBarItem] {
        let homeItem = UITabBarItem(title: "Home", image: UIImage(named: "tabbar_calendar")!, selectedImage: nil)
        let trendsItem = UITabBarItem(title: "Messages", image: UIImage(named: "tabbar_calendar")!, selectedImage: nil)
        let calendarItem = UITabBarItem(title: nil, image: nil, selectedImage: nil)
        let podItem = UITabBarItem(title: "Versus", image: UIImage(named: "tabbar_calendar")!, selectedImage: nil)
        let settingsItem = UITabBarItem(title: "Gifts", image: UIImage(named: "tabbar_calendar")!, selectedImage: nil)
        
        homeItem.tag = 0
        trendsItem.tag = 1
        calendarItem.tag = 2
        podItem.tag = 3
        settingsItem.tag = 4
        
        return [homeItem, trendsItem, calendarItem, podItem, settingsItem]
    }
}

extension TabbarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print(viewController)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        selectedIndex = item.tag
        tabBarController(self, didSelect: viewControllers![item.tag])
    }
}

extension TabbarVC {
    func makeCenterTabbarView() -> CenterTabbarView {
        let view = CenterTabbarView()
        return view
    }
}



