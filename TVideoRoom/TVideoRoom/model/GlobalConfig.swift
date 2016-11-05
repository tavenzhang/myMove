//
//  GlobalConfig.swift
import UIKit

// 首页的选择器的宽度
let Home_Seleted_Item_W: CGFloat = 60.0
let DefaultMargin: CGFloat = 10.0

// MARK: - 全局常用属性
public let StateBarH: CGFloat = UIApplication.shared.statusBarFrame.size.height;
public let NavigationH: CGFloat = 64
public let ScreenWidth: CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight: CGFloat = UIScreen.main.bounds.size.height
public let ScreenBounds: CGRect = UIScreen.main.bounds
public let ShopCarRedDotAnimationDuration: TimeInterval = 0.2

public let LFBNavigationBarWhiteBackgroundColor = UIColor.colorWithCustom(249, g: 250, b: 253)

public let ROOM_SCROOL_BG_COLOR = UIColor.colorWithCustom(240, g: 240, b: 240, a: 1)

// MARK: - Home 属性
public let HotViewMargin: CGFloat = 10
public let HomeCollectionViewCellMargin: CGFloat = 10
public let HomeCollectionTextFont = UIFont.systemFont(ofSize: 14)
public let HomeCollectionCellAnimationDuration: TimeInterval = 1.0
public let isPlusDevice = UIDevice.current.modelName.contains("Plus");
/****************************** 颜色 ********************************/

// MARK: - 常用颜色
public let LFBGlobalBackgroundColor = UIColor.colorWithCustom(239, g: 239, b: 239)
public let LFBNavigationYellowColor = UIColor.colorWithCustom(253, g: 212, b: 49)

//UserDefaults.standard 数据key
public let default_login_name = "login_name"
public let default_login_pwd = "login_pwd"

public let default_domain = "default_domain"
public let default_vdomain = "default_vdomain"
public let default_pdomain = "default_pdomain"
public let default_Active = "default_activePage"
//flurry 统计
public let flurry_enterHome = "enter home";
public let flurry_btn_reg = "click regbtn";
public let flurry_btn_login = "click loginbtn";
public let flurry_login_success = "login_succes";
public let flurry_login_failre = "login_failre";
public let flurry_enter_videoRoom = "videoRoom";

