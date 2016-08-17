//
//  HJSquareTCell.swift
//  FunnySister
//
//  Created by coco on 16/8/16.
//  Copyright © 2016年 XHJ. All rights reserved.
//

import UIKit



private let HJCollectionViewCell_identify = "HJCollectionViewCell_REUSED"

class HJSquareTCell: UITableViewCell {

    static let topPadding: CGFloat = 10  //顶部间距
    static let bottomPadding: CGFloat = 10  //下部间距
    
    static let Vpadding: CGFloat = 10 //垂直间距
    static let Hpadding: CGFloat = 10  //水平间距
    
    static let width = (kHJMainScreenWidth - 10 * Hpadding / 2) / 5  //宽度
    
    internal var squareData = [HJSquare]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(collectionView)
        self.selectionStyle = .None
        collectionView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: private
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()

        flowLayout.itemSize = CGSize(width: width, height: width + 20)
        flowLayout.minimumInteritemSpacing = Hpadding
        flowLayout.minimumLineSpacing = Vpadding
        flowLayout.scrollDirection = .Vertical  //水平
        flowLayout.sectionInset = UIEdgeInsetsMake(topPadding, 5, bottomPadding, 5)
        let view = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        view.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: HJCollectionViewCell_identify)
        view.backgroundColor = UIColor.whiteColor()
        view.delegate = self
        view.dataSource = self
        view.scrollEnabled = false
        return view
    }()

}

extension HJSquareTCell: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.squareData.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HJCollectionViewCell_identify, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.whiteColor()
        let model = self.squareData[indexPath.item]
        if nil == cell.backgroundView {
            let button = HJCustomButton(type: UIButtonType.Custom)
            cell.backgroundView = button
            button.radio = 0.9
            button.setTitle(model.name, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
            button.kf_setImageWithURL(NSURL(string: model.icon)!, forState: UIControlState.Normal)
        } else {
            let button = cell.backgroundView as! HJCustomButton
            button.setTitle(model.name, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)

            button.kf_setImageWithURL(NSURL(string: model.icon)!, forState: UIControlState.Normal)
        }
        return cell
    }
}
extension HJSquareTCell: UICollectionViewDelegate {
    
}
