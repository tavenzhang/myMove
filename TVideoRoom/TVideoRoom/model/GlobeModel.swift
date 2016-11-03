import Foundation
import SwiftyJSON

import Foundation
import UIKit

class VersionModel: NSObject, DictModelProtocol {
	var name: String?;
	var version: NSNumber?;
	var page_active: String?;
	var domains: [DomainModel]?;

	static func customClassMapping() -> [String: String]? {
		return ["domains": "\(DomainModel.self)"];
	}
}

class DomainModel: NSObject {
	var domain: String?;
	var vdomain: String?;
	var pdomain: String?;
	var isOneRoom: NSNumber?;
}
//通用点击回调
typealias block_comom_click = () -> Void;
//用于主页加载数据的函数钩子
typealias blcok_loadDataFun = (Bool) -> Void;
//弹窗回掉
typealias block_alert = () -> Void;
//登陆回调
typealias block_alertLogin = (_ name: String, _ pwd: String) -> Void;
//简单输入
typealias bock_alertSimpleInput = (_ data: String) -> Void;
//发送聊天
typealias block_sendMessage = (_ msg: String) -> Void
//发送礼物
typealias block_sebtGift = () -> Void
//点击发送
typealias block_sendBtnClick = () -> Void
//选择发送礼物数量
typealias block_changeGitNum = (_ data: AnyObject) -> Void;
//自定义bar 按钮点击
typealias block_tabClick = (_ tag: Int) -> Void;
