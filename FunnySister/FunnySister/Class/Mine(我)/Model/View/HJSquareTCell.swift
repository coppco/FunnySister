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

    internal var squareData = [HJSquare]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(collectionView)
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
        let paddingH: CGFloat = 5.0
        let paddingV: CGFloat = 5.0
        let width = (kHJMainScreenWidth - 10 * paddingH) / 5
        flowLayout.itemSize = CGSize(width: width, height: width + 20)
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.minimumLineSpacing = 5
        flowLayout.scrollDirection = .Horizontal  //水平
        
        let view = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        view.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: HJCollectionViewCell_identify)
        view.delegate = self
        view.dataSource = self
        return view
    }()

}

extension HJSquareTCell: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.squareData.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(HJCollectionViewCell_identify, forIndexPath: indexPath)
        let model = self.squareData[indexPath.item]
        if nil == cell.backgroundView {
            let button = HJCustomButton(type: UIButtonType.Custom)
            cell.backgroundView = button
            button.setTitle(model.name, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            button.kf_setImageWithURL(NSURL(string: model.icon)!, forState: UIControlState.Normal)
        } else {
            let button = cell.backgroundView as! HJCustomButton
            button.setTitle(model.name, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)

            button.kf_setImageWithURL(NSURL(string: model.icon)!, forState: UIControlState.Normal)
        }
        return cell
    }
}
extension HJSquareTCell: UICollectionViewDelegate {
    
}
