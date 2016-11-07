//
//  DataTools.swift

import UIKit

enum icoLvType: Int {
	case hostIcoLV;
	case userIcoLv;
	case vipIcoLv;
}

func lvIcoNameGet(_ ico: Int32, type: icoLvType) -> String
{
	var resultStr: String = "";
	switch type
	{
	case .hostIcoLV:
		resultStr = "hlvr\(ico)";
	case .userIcoLv:
		resultStr = "rlv\(ico)";
		case.vipIcoLv:
		resultStr = "vip\(ico)";
	}
	return resultStr;
}

func dec2hex(_ num: Int) -> String {
	return String(format: " % 0X", num);
}

func encodeStr(_ str: String) -> String {
	var es = [String]();
	var s = str.characters.map { String($0) }
	let lenth = s.count;
	for i in 0 ..< lenth
	{
		let c = s[i];
		var ec = c.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed);
		if (c == ec)
		{
			let ucodeNum = (c as NSString).character(at: 0)
			let st = "00" + dec2hex(Int(ucodeNum));
			ec = st.substring(st.characters.count, -2);
		}
		es.append(ec!);
	}
	let resutStr = es.joined(separator: "");
	let regular = try! NSRegularExpression(pattern: " / % / g", options: .caseInsensitive)
	let nsNew = NSMutableString(string: resutStr);
	regular.replaceMatches(in: nsNew, options: .reportProgress, range: NSMakeRange(0, resutStr.characters.count), withTemplate: "");
	return nsNew as String;

}

func deserilObjectWithDictonary(_ json: NSDictionary, cls: AnyClass) -> AnyObject?
{
	let modelTool = DictModelManager.sharedManager
	let model = modelTool.objectWithDictionary(json, cls);
	return model;
}

func deserilObjectWithDictonary(_ json: [String: Any]?, cls: AnyClass) -> AnyObject?
{
	let modelTool = DictModelManager.sharedManager
	let model = modelTool.objectWithDictionary(json as! NSDictionary, cls);
	return model;
}

func deserilObjectsWithArray(_ array: NSArray, cls: AnyClass) -> NSArray?
{
	let modelTool = DictModelManager.sharedManager
	let arr = modelTool.objectsWithArray(array, cls);
	return arr
}

func loginUser(_ name: String, pwd: String) -> Void {
	let passStr = encodeStr(pwd);
	let paraList = ["uname": name, "password": passStr, "sCode": "", "v_remember": 0] as [String: Any];
	var _ = HttpTavenService.requestJsonWithHint(getWWWHttp(HTTP_LOGIN), loadingHint: "登陆验证中", isGet: false, para: paraList as [String: AnyObject]) { (httpResult) in
		if (httpResult.isSuccess)
		{
			if (httpResult.dataJson?["status"].int! == 1)
			{
				let key = httpResult.dataJson!["msg"].string!;
				DataCenterModel.sharedInstance.roomData.userkey = key;
				HttpTavenService.requestJson(getWWWHttp(HTTP_GETUSR_INFO), completionHadble: { (httpResult) in
					if (httpResult.isSuccess) {
						let result = deserilObjectWithDictonary(httpResult.dataJson?.dictionaryObject
							, cls: LoginModel.classForCoder()) as! LoginModel;
						DataCenterModel.sharedInstance.loginData = result;
						Flurry.logEvent(flurry_login_success, withParameters: ["name": result.info?.nickname]);
						NotificationCenter.default.post(name: NSNotification.Name(LOGIN_SUCCESS), object: nil);
						UserDefaults.standard.set(name, forKey: default_login_name);
						UserDefaults.standard.set(pwd, forKey: default_login_pwd);
						UserDefaults.standard.synchronize();
					}
					else {
						Flurry.logEvent(flurry_login_failre);
						showSimplpAlertView(nil, tl: "个人信息获取失败", msg: "请重新登陆试试", btnHiht: "重试", okHandle: {
							var _ = showLoginlert(nil, txtName: "", pwd: "", loginHandle: { (name, pwd) in
								loginUser(name, pwd: pwd);
							})
						})
					} })
			}
			else {
				Flurry.logEvent(flurry_login_fail, withParameters: ["name": name]);
				showSimplpAlertView(nil, tl: "登陆失败", msg: "用户名密码错误", btnHiht: "重试", okHandle: {
					var _ = showLoginlert(nil, txtName: "", pwd: "", loginHandle: { (name, pwd) in
						loginUser(name, pwd: pwd);
					})
				})
			}

		}
	}
}

