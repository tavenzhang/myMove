//
//  GiftShopCell.swift
//  TVideoRoom
//

class GiftShopCell: UICollectionViewCell {
	// MARK: - 初始化子空间
	fileprivate lazy var backImageView: UIImageView = {
		let backImageView = UIImageView()
		return backImageView
	}()

	var nameLabel = UILabel.lableSimple("", corlor: UIColor.black, size: 12, align: NSTextAlignment.center);

	var priceLabel: UILabel = UILabel.lableSimple("", corlor: UIColor.gray, size: 10, align: NSTextAlignment.center);

	var newLabel: UILabel = UILabel.lableSimple("new!", corlor: UIColor.red, size: 9, align: NSTextAlignment.center);

	var addButtonClick: ((_ imageView: UIImageView) -> ())?

	// MARK: - 便利构造方法
	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = UIColor.white
		addSubview(backImageView);
		addSubview(nameLabel);
		addSubview(priceLabel);
		addSubview(newLabel);
		backImageView.snp.makeConstraints { (make) in
			make.centerX.equalTo(self);
			make.top.equalTo(2);
			make.width.height.equalTo(40);
		}
		nameLabel.snp.makeConstraints { (make) in
			make.top.equalTo(backImageView.snp.bottom).offset(0);
			make.centerX.equalTo(self);

		}
		priceLabel.snp.makeConstraints { (make) in
			make.top.equalTo(nameLabel.snp.bottom).offset(0);
			make.centerX.equalTo(self);

		}
		newLabel.snp.makeConstraints { (make) in
			make.top.equalTo(self.snp.top).offset(1);
			make.right.equalTo(self.snp.right).offset(-2)
		}
		self.layer.borderWidth = 1;
		self.layer.borderColor = UIColor.gray.cgColor;

	}
	override var isSelected: Bool {
		didSet {
			super.isSelected = isSelected;
			self.backgroundColor = isSelected ? UIColor.red.withAlphaComponent(0.5) : UIColor.white;
		}
	}

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	// MARK: - 模型set方法
	var shopGiftModel: GiftDetailModel? {
		didSet {
			let gidId = shopGiftModel!.gid!.int32Value;
			let imageUrl = getGiftImagUrl(gidId.description);
			backImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: r_home_videoImgPlaceholder));
			nameLabel.text = shopGiftModel?.name;
			priceLabel.text = (shopGiftModel?.price?.description)! + "钻石";
			nameLabel.isHidden = false;
			newLabel.isHidden = shopGiftModel!.isNew == "0" ;

		}
	}

	// var selected: Bool
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

// MARK: - 布局
	override func layoutSubviews() {
		super.layoutSubviews();
	}

}
