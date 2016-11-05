//
//  RoomMenuBar.swift
//  TVideoRoom
//
import UIKit
import SnapKit

class RoomMenuBar: UIView {
	// MARK: - 初始化子空间
	var menuBar: TabBarMenu?;

	var changeBtnClick: block_tabClick?;

	var menuTabClick: block_tabClick?;

	override init(frame: CGRect) {
		super.init(frame: frame)
		setup();
	}

	deinit {
		changeBtnClick = nil;
		menuTabClick = nil;
		menuBar = nil;
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func regMenuTabClick(_ clickHandle: @escaping block_tabClick)
	{
		menuTabClick = clickHandle;
	}

	func setup() {

		menuBar = TabBarMenu();
		let changeLineBtn = self.createBtn("换线", tag: 3, size: 16, color: UIColor.brown);
		self.addSubview(changeLineBtn);
		self.addSubview(menuBar!);
		menuBar?.snp.makeConstraints { (make) in
			make.width.equalTo(self.width * 3 / 4);
			make.height.equalTo(self);
			make.top.equalTo(self).offset(-4);
			make.left.equalTo(self);
		}
		// 强制更新一次
		self.layoutIfNeeded();
		menuBar?.creatBtnByList(["聊天", "贡献榜", "在线"], txtSize: 15, color: UIColor.brown);
		menuBar!.regClickHandle(tabBtnClikc);
		changeLineBtn.snp.makeConstraints { (make) in
			make.centerY.equalTo(self);
			make.right.equalTo(self.snp.right).offset(-20);
		};
		if (DataCenterModel.isLogin)
		{
			focusServe(DataCenterModel.sharedInstance.roomData.uid, type: 0);
		}
	}
	// 关注按钮 ， 服务器依赖浏览器 暂时保留
	func focusServe(_ uid: String, type: Int) {
		// /** 设置关注状态 0 查询 1:添加 2:取消*/  ?pid={1}&ret={2}
		// let url: String = "\(getWWWHttp(HTTP_V_FOCUS))?pid=\(DataCenterModel.sharedInstance.roomData.uid)&ret=\(type)"
//		HttpTavenService.requestJson(url, isGet: true, para: nil) { [weak self](HttpResult) in
//
//		}

	}

	func tabBtnClikc(_ tag: Int)
	{
		if (menuTabClick != nil)
		{
			menuTabClick!(tag);
		}
	}

	func createBtn(_ title: String, tag: Int, size: CGFloat = 14, color: UIColor? = UIColor.brown) -> UIButton {
		let btn = UIButton()

		btn.titleLabel!.font = UIFont.systemFont(ofSize: size);
		btn.setTitle(title, for: UIControlState())
		btn.setTitleColor(color?.withAlphaComponent(0.6), for: .highlighted);
		btn.setTitleColor(color, for: UIControlState())
		btn.tag = tag;
		btn.addTarget(self, action: #selector(self.click), for: .touchUpInside)
		return btn
	}

	// 点击事件
	func click(_ btn: UIButton) {
		if (changeBtnClick != nil)
		{
			changeBtnClick!(btn.tag);
		}
	}

	// 切换按钮
	func movebtnByTag(_ selectedType: Int) {
		menuBar?.movebtnByTag(selectedType);
	}

}
