//
//  HotLiveCell.swift
//  TVideoRoom
//
//  Created by  on 16/10/4.
//  Copyright © 2016年 . All rights reserved.
//

import UIKit

class HotLiveCell: UICollectionViewCell {
	@IBOutlet weak var txtperson: UILabel!
	@IBOutlet weak var imgLv: UIImageView!;
	@IBOutlet weak var txtname: UILabel!
	@IBOutlet weak var imgBigView: UIImageView!;
	@IBOutlet weak var imglive: UIImageView!
	@IBOutlet weak var imgHeadView: UIImageView!
	@IBOutlet weak var btnLocation: UIButton!;

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	var hotData: Activity?
	{
		didSet {
			let totalStr = "\(hotData!.total!.intValue)人观看" as NSString;
			let attStr = NSMutableAttributedString(string: totalStr as String);
			let attrDic = [NSForegroundColorAttributeName: UIColor.purple, NSFontAttributeName: UIFont.systemFont(ofSize: 18)];

			attStr.addAttributes(attrDic, range: totalStr.range(of: "\(hotData!.total!)"))
			self.txtperson.attributedText = attStr;
			self.txtname.text = hotData?.username;
			let imageUrl = NSString(format: HTTP_IMAGE as NSString, hotData!.headimg!) as String;
			self.imgHeadView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "v2_placeholder_full_size"));
			self.imgHeadView.layer.cornerRadius = 20;
			self.imgHeadView.layer.masksToBounds = true;

			// self.imgHeadView.layer.borderColor = UIColor.gray.cgColor;
			// self.imgHeadView.layer.borderWidth = 1;
			self.imgBigView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "v2_placeholder_full_size"));
			self.imgBigView.width = ScreenWidth;
			self.imgBigView.height = ScreenWidth * 3 / 4;

			imglive.isHidden = (hotData?.live_status == 0);
			btnLocation.setTitle("来自神秘花园", for: UIControlState());
			// let ico = "hlvr\(hotData!.lv_exp!.intValue)";
			imgLv.image = UIImage(named: lvIcoNameGet(hotData!.lv_exp!.int32Value, type: .hostIcoLV));

		}
	}
}
