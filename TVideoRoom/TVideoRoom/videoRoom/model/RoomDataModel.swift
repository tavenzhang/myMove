

/// 房间内具体信息
class RoomData: NSObject {

	var port: Int = 9013;
	var sid: String = "";
	var roomId: Int = 1761828
	var pass: String = "";
	var isPublish = false;
	var publishUrl = "";
	var myMoney = 0;
	// var key = "d382538698b6e79c7d2ea8914e12e623";
	var userkey = "";
	var aeskey = "";
	var rtmpList = [RtmpInfo]();
	var lastRtmpUrl: String = "";
	var uid: String = "0";
	var rtmpPath: String {
		get {
			// return lastRtmpUrl + "/" + sid + " live=1";
			return lastRtmpUrl + "/" + sid;
		}
	}
	var socketIp: String? ;
	var isVideoPlaying: Bool = false;
	var rankGifList: [RankGiftModel] = [];

	// 礼物数据集合
	var giftDataManager: [GiftCateoryModel] = [];
	var playerList = [playInfoModel]();
	var http_flv_testPort = 19333;
	func getGiftNameById(gidtId: Int) -> String {
		for item in giftDataManager {
			if ((item.items?.count)! > 0) {
				for info in item.items! {
					if (info.gid?.intValue == gidtId) {
						return info.name!;

					}
				}
			}
		}
		return "";
	}
	// 调整用户主播列表数据
	func changPlayerList(_ newList: [playInfoModel], isDelete: Bool = false) -> Void {

		for item in newList {
			var isNew: Bool = true;
			for oldItem in playerList
			{
				if (item.uid?.int32Value == oldItem.uid?.int32Value)
				{
					isNew = false;
					if (isDelete)
					{
						playerList.remove(at: playerList.index(of: oldItem)!);
					}
					break;
				}
			}
			if (isNew && !isDelete)
			{
				playerList.append(item);
			}
		}
	}

	// 登陆失效以后
	func reset() {
		port = 9013;
		sid = "";
		roomId = 0;
		pass = "";
		isPublish = false;
		publishUrl = "";
		myMoney = 0;
		userkey = "";
		aeskey = "";
		rtmpList.removeAll();
		lastRtmpUrl = "";
		uid = ""
	}
	// 重新进入房间数据预处理
	func prepareRoomData() {
		rtmpList.removeAll();
		playerList.removeAll();
		lastRtmpUrl = "";
		DataCenterModel.sharedInstance.roomData.socketIp = "";
		DataCenterModel.sharedInstance.roomData.port = 0;
	}

}

class RtmpInfo {
	var rtmpUrl: String = "";
	var rtmpName: String = "";
	var isEnable: Bool = false;
	var httpUrl: String = "";
	var isHttp: Bool = false;
}

class GiftChooseModel {

	init(lb: String, num: Int, isVip: Bool)
	{
		label = lb;
		data = num;
		vip = isVip;
	}

	var label: String = "";
	var data: Int = 0;
	var vip: Bool = false;
}

class GiftCateoryModel: NSObject, DictModelProtocol {
	// {"category":2,"name":"贵族","items":...
	var category: NSNumber?;
	var name: String = "";
	var items: [GiftDetailModel]?

	static func customClassMapping() -> [String: String]? {
		return ["items": "\(GiftDetailModel.self)"]
	}
}

//详细礼物信息
class GiftDetailModel: NSObject {
	// {"gid":310031,"price":1,"category":1,"name":"七彩魅瑰","desc":"","sort":"1","isNew":"0"},
	var gid: NSNumber?;
	var price: NSNumber?;
	var category: NSNumber?;
	var name: String?;
	var desc: String?;
	var sort: String?;
	var isNew: String?;
}
//用户列表个人信息
//{"vip":0,"hidden":0,"sex":0,"ruled":3,"richLv":1,"lv":0,"name":"倾城古娘","icon":0,"uid":1011095,"car":0}
class playInfoModel: NSObject {
	var ruled: NSNumber?;
	var name: String?;
	var icon: NSNumber?;
	var uid: NSNumber?;
	var richLv: NSNumber = 0.0;
	var lv: NSNumber?;
	var vip: NSNumber?;
}
