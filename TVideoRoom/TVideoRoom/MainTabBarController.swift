//
//  MainTabBarConntroller.swift
//  TVideoRoom
//
//  Created by  on 16/6/25.
//  Copyright © 2016年 . All rights reserved.
//
import UIKit

class MainTabBarController: UITabBarController {

	fileprivate var fristLoadMainTabBarController: Bool = true
	fileprivate var adImageView: UIImageView?
	var adImage: UIImage? {
		didSet {
			weak var tmpSelf = self
			adImageView = UIImageView(frame: ScreenBounds)
			adImageView!.image = adImage!
			self.view.addSubview(adImageView!)

			UIImageView.animate(withDuration: 3, animations: { () -> Void in
				tmpSelf!.adImageView!.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
				tmpSelf!.adImageView!.alpha = 0
				}, completion: { (finsch) -> Void in
				tmpSelf!.adImageView!.removeFromSuperview()
				tmpSelf!.adImageView = nil
			})
		}
	}

	// MARK:- view life circle
	override func viewDidLoad() {
		super.viewDidLoad();
		self.buildMainTabBarChildViewController();
//		#if DEBUG
//			let a = 2;
//		#else
//			let a = 3;
//		#endif
		addNotifycation();
		self.delegate = self;
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated);
	}

	func getView(_ name: String) -> UIViewController {
		return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name);
	}

	func addNotifycation() {
		NotificationCenter.default.addObserver(self, selector: #selector(self.showLoginView), name: NSNotification.Name(rawValue: SHOW_LOGOM_VIEW), object: nil);
	}

	func showLoginView() {
		self.selectedIndex = 3;
	}

	fileprivate func buildMainTabBarChildViewController() {
		let manView = MainPageViewController();
		tabBarControllerAddChildViewController(manView, title: "大厅", imageName: r_tabBtn_home, selectedImageName: r_tabBtn_home_r, tag: 0)
		tabBarControllerAddChildViewController(RankViewController(), title: "排行", imageName: r_tabBtn_rank, selectedImageName: r_tabBtn_rank_r, tag: 1)
		tabBarControllerAddChildViewController(ActiveViewController(navigationTitle: "活动", urlStr: getWWWHttp(MyActivePage), isOpenNow: false), title: "活动", imageName: r_tabBtn_active, selectedImageName: r_tabBtn_active_r, tag: 2)
		tabBarControllerAddChildViewController(MyDetailViewController(), title: "我", imageName: r_btn_me, selectedImageName: r_btn_me_r, tag: 3);
		checkAutoLogin();

	}

	private func tabBarControllerAddChildViewController(_ childVC: UIViewController, title: String, imageName: String, selectedImageName: String, tag: Int) {
		let vcItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
		vcItem.tag = tag

		// vcItem.animation = RAMBounceAnimation()
		childVC.tabBarItem = vcItem
		self.view.tintColor = UIColor.colorWithCustom(217, g: 44, b: 114);

		let navigationVC = BaseNavigationController(rootViewController: childVC)
		addChildViewController(navigationVC)
	}

	func checkAutoLogin() {
		let domain = UserDefaults.standard.string(forKey: default_domain);
		let statue = UserDefaults.standard.bool(forKey: default_AUTO_LOGIN);
		let name = UserDefaults.standard.string(forKey: default_login_name);
		let pwd = UserDefaults.standard.string(forKey: default_login_pwd);
		if (statue == true && ((name != nil) && (name != "")) && ((pwd != nil) && (pwd != "")) && ((domain != nil) && (domain != "")))
		{
			if (DataCenterModel.isLogin == false)
			{
				loginUser(name!, pwd: pwd!);
			}

		}
	}

}
extension MainTabBarController: UITabBarControllerDelegate {
	func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

	}

}
