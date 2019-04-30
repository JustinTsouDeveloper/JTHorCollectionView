//
//  JTHorCollectionView.swift
//  JTHorCollectionView
//
//  Created by Justin Tsou on 2019/4/30.
//  Copyright © 2019 iOSDeveloper. All rights reserved.
//

import UIKit

public protocol JTHorCollectionViewDelegate: class {
    func didCollectionViewSelectItem(indexPath: IndexPath, text: String)
}

public class JTHorCollectionView: UIView {
    
    @IBOutlet var contentView: UIView!
    private var collectionView:HorizontallyCollectionView?
    private var textList: Array<String>?
    private var collectionViewLayout:UICollectionViewFlowLayout?
    public weak var delegate: JTHorCollectionViewDelegate?
    private let textAmount = 4
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(textList:Array<String>,frame:CGRect) {
        self.init(frame: frame)
        self.textList = textList
        self.setupCollectionView(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView(frame:CGRect) {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "JTHorCollectionView", bundle: bundle)
        contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        contentView.frame = bounds
        
        let viewFrame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.collectionViewLayout = self.setupCollectionViewFlowLayout()
        self.collectionView = HorizontallyCollectionView(textList: self.textList!, frame: viewFrame, layout: self.collectionViewLayout!)
        
        collectionView?.delegates = self
        contentView.addSubview(self.collectionView!)
        addSubview(contentView)
    }
    
    private func setupCollectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let collectionViewLayout = UICollectionViewFlowLayout()
        collectionViewLayout.minimumLineSpacing = CGFloat.leastNonzeroMagnitude
        collectionViewLayout.minimumInteritemSpacing = CGFloat.leastNonzeroMagnitude
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = self.textList!.count < textAmount ? CGSize(width: self.frame.size.width / CGFloat(self.textList!.count) , height: self.frame.size.height) : CGSize(width: self.frame.size.width / CGFloat(textAmount) , height: self.frame.size.height)
        return collectionViewLayout
    }
    
    public func setSelectTextColor (color:UIColor) {
        self.collectionView?.setSelectTextColor(color: color)
    }
    
    public func setDeselectTextColor(color:UIColor) {
        self.collectionView?.setDeselectTextColor(color: color)
    }
    
    public func setSelectCellLabelBorderColor(color:UIColor) {
        self.collectionView?.setSelectCellLabelBorderColor(color: color)
    }
    
    public func setDeselectCellLabelBorderColor(color:UIColor) {
        self.collectionView?.setDeselectCellLabelBorderColor(color: color)
    }
}

extension JTHorCollectionView: HorizontallyCollectionViewDelegate {
    func didCollectionViewSelectItem(indexPath: IndexPath, text: String) {
        self.delegate?.didCollectionViewSelectItem(indexPath: indexPath, text: text)
    }
}
