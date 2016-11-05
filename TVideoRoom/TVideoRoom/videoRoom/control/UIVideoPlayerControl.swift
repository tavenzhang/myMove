//
//  UIVideoPlayControl.swift

import UIKit
import TRtmpPlay

class UIVideoPlayControl: UIViewController {

	var vc: KxMovieViewController?;
	var lastRtmpUrl: String = "";

	override func viewDidLoad() {
		super.viewDidLoad();
		addNSNotification();
		self.view.backgroundColor = UIColor.black.withAlphaComponent(0.9);
	}

	deinit {
		NotificationCenter.default.removeObserver(self);
	}

	override func viewDidDisappear(_ animated: Bool) {
		NotificationCenter.default.removeObserver(self);
		vc?.close();
		vc = nil;
	}

	func addNSNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(self.rtmpStartPlay), name: NSNotification.Name(rawValue: RTMP_START_PLAY), object: nil);
		NotificationCenter.default.addObserver(self, selector: #selector(self.appToF2BRUN), name: NSNotification.Name(rawValue: ENTER_F2B_RUN), object: nil);
		NotificationCenter.default.addObserver(self, selector: #selector(self.appToB2FRUN), name: NSNotification.Name(rawValue: ENTER_B2F_RUN), object: nil);
	}

	func appToF2BRUN(_ notification: Notification) {
		LogHttp("appToF2BRUN----vc=\(vc)")
		vc?.pause()
	}

	func appToB2FRUN(_ notification: Notification) {
		LogHttp("appToB2FRUN----vc=\(vc)")
		vc?.play();
	}

	// 测试rtmp 播放
	func rtmpStartPlay(_ notification: Notification) {
		// [-] 正常播放模式 式正常播放模式 30043581144191618|15526D99B51B7DAA0CF99539B82F013B rtmp://119.63.47.233:9945/proxypublish
		let roomData = DataCenterModel.sharedInstance.roomData;
		roomData.lastRtmpUrl = notification.object as! String;
		lastRtmpUrl = roomData.rtmpPath;
		if (lastRtmpUrl.contains("http"))
		{
			lastRtmpUrl = lastRtmpUrl + ".flv";
		}
		if (vc != nil)
		{
			vc?.close();
			vc?.view.removeFromSuperview();
			// vc?.view.removeGestureRecognizer(ges!);
			vc = nil;
		}
		if (lastRtmpUrl.contains("rtmp") || lastRtmpUrl.contains("http"))
		{
			print("rtmp filepath=\(lastRtmpUrl)");
			var parametersD = [AnyHashable: Any]();
			parametersD[KxMovieParameterMinBufferedDuration] = 2;
			parametersD[KxMovieParameterMaxBufferedDuration] = 10;
			vc = KxMovieViewController.movieViewController(withContentPath: lastRtmpUrl, parameters: parametersD) as! KxMovieViewController?;
			vc!.view.frame = CGRect(x: 0, y: 0, width: self.view.width, height: self.view.height);
			vc!.view.isUserInteractionEnabled = false;
			self.view.addSubview(vc!.view);
			self.addChildViewController(vc!);
			self.view.bringSubview(toFront: vc!.view);
		}
		else {
			showSimplpAlertView(self, tl: "主播已停止直播", msg: "请选择其他房间试试！", btnHiht: "了解");
		}
	}

	// 切换线路
	func showChangSheetView(_ tag: Int)
	{
		let alert = UIAlertController(title: "视频卡顿 请换线试试", message: nil, preferredStyle: .actionSheet);
		alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: self.selectNewLine));
		let rtmpList = DataCenterModel.sharedInstance.roomData.rtmpList;
		for item in rtmpList
		{
			let isNow = lastRtmpUrl.contains(item.rtmpUrl);
			if (item.isEnable && !isNow)
			{
				alert.addAction(UIAlertAction(title: item.rtmpName, style: .destructive, handler: selectNewLine));
			}

		}
		present(alert, animated: true, completion: nil);
	}

	// 最终选择线路
	func selectNewLine(_ action: UIAlertAction) {
		let rtmpList = DataCenterModel.sharedInstance.roomData.rtmpList;
		for item in rtmpList
		{
			if (action.title! == item.rtmpName)
			{
				let ns = Notification(name: Notification.Name(rawValue: RTMP_START_PLAY), object: item.rtmpUrl);
				rtmpStartPlay(ns);
				return;
			}
		}
	}

}
