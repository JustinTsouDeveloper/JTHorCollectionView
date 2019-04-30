//
//  HorizontallyCollectionView.swift
//  JTHorCollectionView
//
//  Created by Justin Tsou on 2019/4/30.
//  Copyright © 2019 iOSDeveloper. All rights reserved.
//

import UIKit

protocol HorizontallyCollectionViewDelegate: class {
    func didCollectionViewSelectItem(indexPath:IndexPath, text:String)
}

class HorizontallyCollectionView: UICollectionView {
    
    weak var delegates: HorizontallyCollectionViewDelegate?
    private var textList: Array<String>?
    private var currentIndexPath:IndexPath?
    private let lightgray = UIColor(red: 211.0/255.0, green: 211.0/255.0, blue: 211.0/255.0, alpha: 1)
    private let dimgray = UIColor(red: 105.0/255.0, green: 105.0/255.0, blue: 105.0/255.0, alpha: 1)
    private var selectCellLabelBorderColor = UIColor.white
    private var deselectCellLabelBorderColor = UIColor.white
    private var selecrTextColor = UIColor.black
    private var deselecrTextColor = UIColor.groupTableViewBackground
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    convenience init(textList: Array<String>, frame: CGRect, layout: UICollectionViewLayout) {
        self.init(frame: frame, collectionViewLayout:layout)
        self.textList = textList
        self.currentIndexPath = IndexPath.init(row: 0, section: 0)
        self.setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView() {
        self.dataSource = self
        self.delegate = self
        self.isPagingEnabled = true
        self.backgroundColor = .clear
        self.showsHorizontalScrollIndicator = false
        let bundle = Bundle(for: type(of: self))
        self.register(UINib(nibName: "HorizontallyCollectionViewCell", bundle: bundle), forCellWithReuseIdentifier: "HorizontallyCollectionViewCell")
    }
    
    func setSelectTextColor (color:UIColor) {
        self.selecrTextColor = color
    }
    
    func setDeselectTextColor(color:UIColor) {
        self.deselecrTextColor = color
    }
    
    func setSelectCellLabelBorderColor(color:UIColor) {
        self.selectCellLabelBorderColor = color
    }
    
    func setDeselectCellLabelBorderColor(color:UIColor) {
        self.deselectCellLabelBorderColor = color
    }
}

extension HorizontallyCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.textList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let horCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HorizontallyCollectionViewCell", for: indexPath) as! HorizontallyCollectionViewCell
        
        let text = self.textList![indexPath.row]
        horCell.horTextLabel.text = text
        
        if self.currentIndexPath?.row == indexPath.row {
            horCell.setHorTextLabelBorderColor(color: self.selectCellLabelBorderColor)
            horCell.setHorTextLabelTextColor(color: self.selecrTextColor)
        }else {
            horCell.setHorTextLabelBorderColor(color: self.deselectCellLabelBorderColor)
            horCell.setHorTextLabelTextColor(color: self.deselecrTextColor)
        }
        
        return horCell
    }
}

extension HorizontallyCollectionView:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
        if self.currentIndexPath != indexPath {
            self.reloadData()
            self.delegates?.didCollectionViewSelectItem(indexPath: indexPath, text: self.textList![indexPath.row])
        }
        
        self.currentIndexPath = indexPath
    }
    
}
