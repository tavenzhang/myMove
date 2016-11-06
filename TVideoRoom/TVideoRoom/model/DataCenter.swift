//
//  DataProxy.swift
//  TVideo
//
//  Created by  on 16/6/1.
//  Copyright © 2016年 . All rights reserved.
//

import Foundation
import SwiftyJSON

//数据管理中心
class DataCenterModel {

	internal static let sharedInstance = DataCenterModel()
   private init() { }

	var isOneRoom: Bool = false;
	// 主页数据；
	var homeData: HomeData = HomeData();
	// 房间内数据
	var roomData: RoomData = RoomData();

	var loginData: LoginModel?;

	class var isLogin: Bool {
		return (DataCenterModel.sharedInstance.roomData.userkey != "");
	}

	class func enterVideoRoom(rid: Int, vc: UINavigationController?) {
		if (isLogin) {
			let roomview: VideoRoomUIViewVC = VideoRoomUIViewVC();
			roomview.roomId = rid;
			DataCenterModel.sharedInstance.roomData.roomId = rid;
			vc?.pushViewController(roomview, animated: true);
		}
		else {
			showAlertHandle(vc!, tl: "您当前是游客", cont: "无法参与送礼和聊天，你确定以游客身份进入吗", okHint: "登陆", cancelHint: "进入", canlHandle: {
				let roomview: VideoRoomUIViewVC = VideoRoomUIViewVC();
				DataCenterModel.sharedInstance.roomData.roomId = rid;
				roomview.roomId = rid;
				vc?.pushViewController(roomview, animated: true);
				}, okHandle: {
				NotificationCenter.default.post(name: Notification.Name(rawValue: SHOW_LOGOM_VIEW), object: nil);
			})
		}
	}

}
