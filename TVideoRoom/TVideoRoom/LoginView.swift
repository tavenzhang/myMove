//
//  InfoView.swift

import UIKit
import SnapKit

class LoginView: UIView {

	var txtName: UILabel?;
	var txtId: UILabel?;
	var txtSex: UILabel?;
	var txtArea: UILabel?;
	var txtMail: UILabel?;
	var txtTitle: UILabel?;
	var moneyTitle: UILabel?;

	var txtLv: UILabel?;
	var imgViewLv: UIImageView?;
	var imgHeadView: UIImageView?;
	var defaultInfo: PersonInfoModel = PersonInfoModel();
	var rbtAuto: UISwitch?;

	weak var parentViewVC: MyDetailViewController?;
	var reyBtn: UIButton?;
	var logBtn: UIButton?;

	var isLoginSucess: Bool {
		didSet {
			reyBtn?.isHidden = isLoginSucess;
			logBtn?.isHidden = isLoginSucess;
			moneyTitle?.isHidden = !isLoginSucess;
			rbtAuto?.isHidden = !isLoginSucess;
		}
	}
	override init(frame: CGRect) {
		isLoginSucess = false;
		super.init(frame: frame);
		setup();
		resetDataView();
		NotificationCenter.default.addObserver(self, selector: #selector(self.flushServiceModel), name: NSNotification.Name(LOGIN_SUCCESS), object: nil)
	}

	func resetDataView() {
		isLoginSucess = false;
		defaultInfo.nickname = "你是游客,请先登录~";
		defaultInfo.safemail = "???";
		defaultInfo.sex = NSNumber(value: -1);
		defaultInfo.lv_exp = NSNumber(value: 000000);
		defaultInfo.lv_rich = NSNumber(value: 0);
		defaultInfo.uid = NSNumber(value: 000);
		defaultInfo.points = NSNumber(value: 0);
		imgViewLv?.isHidden = true;
		updateMyInfo(defaultInfo);
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented");
	}

	func setup() -> Void {
		let img = UIImageView(image: UIImage(named: "userBg"));
		img.sizeToFit();
		imgHeadView = UIImageView(image: UIImage(named: "headHolder"));
		img.addSubview(imgHeadView!);
		self.addSubview(img);
		reyBtn = UIButton.BunImgSimple(UIImage(named: "regbtn")!, hightLightImage: nil, target: self, action: #selector(self.clickReg));
		logBtn = UIButton.BunImgSimple(UIImage(named: "loginBtn")!, hightLightImage: nil, target: self, action: #selector(self.clickLogin));
		self.addSubview(reyBtn!);
		self.addSubview(logBtn!)
		let scaleNum: CGFloat = 1.5;
		imgHeadView?.layer.cornerRadius = 20;
		imgHeadView?.layer.masksToBounds = true;
		imgHeadView!.scale(scaleNum, ySclae: scaleNum);
		reyBtn!.scale(scaleNum, ySclae: scaleNum);
		logBtn!.scale(scaleNum, ySclae: scaleNum);

		img.snp.makeConstraints { (make) in
			make.width.equalTo(self.width);
			let h = (self.width / 720) * 267;
			make.height.equalTo(h);
			make.left.equalTo(self.snp.left);
			make.top.equalTo(self.snp.top);
		}
		self.layoutIfNeeded();
		imgHeadView!.snp.makeConstraints { (make) in
			make.centerX.equalTo(img.snp.centerX);
			make.centerY.equalTo(img.snp.centerY).offset(-20);
			make.width.height.equalTo(40);
		}
		reyBtn!.snp.makeConstraints { (make) in
			make.right.equalTo(imgHeadView!.snp.left).offset(2);
			make.top.equalTo(imgHeadView!.snp.bottom).offset(37);
		}
		logBtn!.snp.makeConstraints { (make) in
			make.left.equalTo(imgHeadView!.snp.right).offset(-2);
			make.top.equalTo(imgHeadView!.snp.bottom).offset(37);
		}
		txtName = UILabel.labelSimpleToView(self, 16, UIColor.white);
		img.addSubview(txtName!);
		txtName?.snp.makeConstraints { (make) in
			make.centerX.equalTo(img.centenX);
			make.centerY.equalTo(img.snp.centerY).offset(22);
		}
		moneyTitle = UILabel.labelSimpleToView(self, 12, UIColor.green);
		img.addSubview(moneyTitle!);
		moneyTitle?.snp.makeConstraints({ (make) in
			make.top.equalTo((txtName?.snp.bottom)!).offset(5);
			make.centerX.equalTo(img.centenX);
		})
		moneyTitle?.isHidden = true;
		// 表格信息

		txtId = UILabel.labelSimpleToView(self, 13, UIColor.gray);
		txtSex = UILabel.labelSimpleToView(self, 13, UIColor.gray);

		txtArea = UILabel.labelSimpleToView(self, 13, UIColor.gray);
		txtMail = UILabel.labelSimpleToView(self, 13, UIColor.gray);
		txtTitle = UILabel.labelSimpleToView(self, 13, UIColor.gray);
		txtLv = UILabel.labelSimpleToView(self, 13, UIColor.gray);

		txtId?.snp.makeConstraints { (make) in
			make.top.equalTo (img.snp.bottom).offset(10);
			make.left.equalTo(img.snp.left).offset(10); }
		txtMail?.snp.makeConstraints { (make) in
			make.top.equalTo ((txtId?.snp.bottom)!).offset(10);
			make.left.equalTo((txtId?.snp.left)!);
		}
		txtTitle?.snp.makeConstraints { (make) in
			make.top.equalTo ((txtMail?.snp.bottom)!).offset(10);
			make.left.equalTo((txtMail?.snp.left)!);
		}

		txtSex?.snp.makeConstraints { (make) in
			make.top.equalTo ((txtId?.snp.top)!);
			make.left.equalTo((txtId?.snp.right)!).offset(20);
		}

		txtArea?.snp.makeConstraints { (make) in
			make.top.equalTo ((txtSex?.snp.top)!);
			make.left.equalTo((txtSex?.snp.right)!).offset(20);
		}

		txtLv?.snp.makeConstraints { (make) in
			make.top.equalTo ((txtTitle?.snp.top)!);
			make.left.equalTo((txtId?.snp.left)!);
		}
		imgViewLv = UIImageView();
		self.addSubview(imgViewLv!);
		imgViewLv?.snp.makeConstraints({ (make) in
			make.centerY.equalTo((txtLv?.snp.centerY)!);
			make.left.equalTo((txtLv?.snp.right)!).offset(20);
		})
		let alb = UILabel.labelSimpleToView(self, 13, UIColor.gray);
		alb.text = "自动登陆:";
		alb.snp.makeConstraints({ (make) in
			make.centerY.equalTo((txtLv?.snp.centerY)!);
			make.left.equalTo((imgViewLv?.snp.right)!).offset(20);
		})
		rbtAuto = UISwitch();
		self.addSubview(rbtAuto!);
		rbtAuto!.addTarget(self, action: #selector(self.changeAutoLogin), for: .valueChanged);
		rbtAuto!.snp.makeConstraints({ (make) in
			make.width.equalTo(50);
			make.height.equalTo(20);
			make.centerY.equalTo((txtLv?.snp.centerY)!).offset(-12);
			make.left.equalTo(alb.snp.right).offset(5);
		})
		let statue = UserDefaults.standard.bool(forKey: default_AUTO_LOGIN);
		rbtAuto!.setOn(statue, animated: true);

	}

	func changeAutoLogin() {
		UserDefaults.standard.set(rbtAuto!.isOn, forKey: default_AUTO_LOGIN);
		UserDefaults.standard.synchronize();
	}

	func updateMyInfo(_ info: PersonInfoModel) {
		txtName?.text = info.nickname!;
		txtId?.text = "ID:\(info.uid!)";
		txtArea?.text = "地区:秘密基地"
		txtMail?.text = "邮箱:\(info.safemail!)";
		// txtTitle?.text = "头衔:\(info.titleName!)";
		txtLv?.text = "财富等级: \(info.lv_rich!)     头衔:";
		txtSex?.text = "性别:\(info.sexName)";
		if (info.roled?.intValue == 3)
		{
			imgViewLv!.image = UIImage(named: lvIcoNameGet((info.lv_exp!.int32Value), type: .hostIcoLV));
			imgViewLv!.scale(2, ySclae: 2);
			imgViewLv?.isHidden = false;
		}
		else {
			imgViewLv!.image = UIImage(named: lvIcoNameGet((info.lv_rich!.int32Value), type: .userIcoLv));
			imgViewLv!.scale(2, ySclae: 2)
			imgViewLv?.isHidden = false;
		}
		moneyTitle?.text = "余额:\(info.points!.intValue) 钻";
	}

	func clickReg() {
		Flurry.logEvent(flurry_btn_reg);
		// showSimplpAlertView(parentViewVC, tl: "", msg: "注册功能暂未开放!");
		showAlertHandle(nil, tl: "账号注册", cont: "请点击【前往】去网站注册！", okHint: "前往", cancelHint: "取消", canlHandle: nil) {
			let url = URL(string: getWWWHttp(
				"http://%@"));
			if #available(iOS 10.0, *) {
				UIApplication.shared.open(url!, options: [:], completionHandler: nil)
			} else {
				UIApplication.shared.openURL(url!)
			}
		}

	}

	func clickLogin() {
		Flurry.logEvent(flurry_btn_login);
		var myName = UserDefaults.standard.string(forKey: default_login_name);
		var mypwd = UserDefaults.standard.string(forKey: default_login_pwd);
		myName = myName == nil ? "" : myName;
		mypwd = mypwd == nil ? "" : mypwd;
		var _ = showLoginlert(parentViewVC, txtName: myName!, pwd: mypwd!)
		{ (name, pwd) in
			loginUser(name, pwd: pwd);
		}
	}

	func flushServiceModel() {

		if (DataCenterModel.sharedInstance.loginData != nil)
		{
			let result = DataCenterModel.sharedInstance.loginData!;
			self.defaultInfo = result.info!;
			self.updateMyInfo((self.defaultInfo));
			Flurry.logEvent(flurry_login_success, withParameters: ["name": (self.defaultInfo).nickname!, "id": (self.defaultInfo).uid]);
			let imageUrl = NSString(format: HTTP_SMALL_IMAGE as NSString, (self.defaultInfo.headimg!)) as String;
			self.imgHeadView?.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "v2_placeholder_full_size"));
			// 设置关注数据
			self.isLoginSucess = true;
			if (result.myfav != nil) {
				self.parentViewVC?.focusModel?.msgNum = (result.myfav?.count)!;
				self.parentViewVC?.focusModel?.targeData = result.myfav as AnyObject?;
			}
			if (result.gg != nil)
			{
				self.parentViewVC?.oneByoneData?.msgNum = (result.gg?.count)!;
				self.parentViewVC?.oneByoneData?.targeData = result.gg as AnyObject?;
			}
			// 设置私信
			self.parentViewVC?.privateMail?.msgNum = (result.myres?.count)!;
			self.parentViewVC?.privateMail?.targeData = result.myres as AnyObject?;
			self.parentViewVC?.flushTable();
		}
	}

}
