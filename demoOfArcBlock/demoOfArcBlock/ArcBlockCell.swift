//
//  ArcBlockCell.swift
//  demoOfArcBlock
//
//  Created by 董月峰 on 2024/12/25.
//

import UIKit
import SnapKit
import Kingfisher

let coverPre = "https://www.arcblock.io/content/uploads"

class ArcblockCell: UITableViewCell {
    var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    var excerpt: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    var labels: [String] = []
    var labelsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSizeMake(30, 30)
        let cv = UICollectionView(frame:.zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.register(LabelCell.self, forCellWithReuseIdentifier: String(describing: LabelCell.self))
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    var publishTime: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    // https://www.arcblock.io/content/uploads/4fb1d71178a16485bbf0c5c4979d8c6e.png
    var cover: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.backgroundColor = CGColor(gray: 0.5, alpha: 0.5)
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        contentView.layer.backgroundColor = UIColor(white: 0, alpha: 0.05).cgColor
        
        contentView.addSubview(title)
        title.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(0)
            make.right.equalTo(-16)
            make.height.equalTo(30)
        }
        
        contentView.addSubview(publishTime)
        publishTime.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(title.snp.bottom).offset(-5)
            make.height.equalTo(20)
        }
        
        contentView.addSubview(cover)
        cover.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.equalTo(publishTime.snp.bottom)
            make.width.equalTo(80)
            make.height.equalTo(60)
//            make.bottom.equalTo(-10)
        }
        
        // https://www.arcblock.io/blog/zh/arcblock-announces-google-cloud-partnership
        contentView.addSubview(excerpt)
        excerpt.snp.makeConstraints { make in
            make.left.equalTo(cover.snp.right).offset(5)
            make.top.equalTo(cover.snp.top)
            make.right.equalTo(-16)
            make.bottom.equalTo(cover.snp.bottom)
            
        }
        
        labelsCollection.dataSource = self
        labelsCollection.delegate = self
        contentView.addSubview(labelsCollection)
        labelsCollection.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.top.equalTo(cover.snp.bottom)
            make.height.equalTo(30)
            make.bottom.equalTo(-5)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configItem(item:Article) {
        title.text = item.title
        excerpt.text = item.excerpt
        let url = URL(string: (coverPre + item.cover))
        cover.kf.setImage(with: url)
        // 若数量为0则更新约束，设置隐藏 这里因为labels一直都有数据先不做
        labels = item.labels
        labelsCollection.reloadData()
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = inputFormatter.date(from: item.publishTime) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "yyyy年MM月dd日"
            publishTime.text = outputFormatter.string(from: date)
        } else {
            publishTime.text = "xxxxx"
        }
        
    }
    
    
}

extension ArcblockCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LabelCell.self), for: indexPath) as! LabelCell
        cell.label.text = labels[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacing: CGFloat) -> CGFloat {
        return 10
    }
}

class LabelCell: UICollectionViewCell {
    
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(3)
            make.left.equalTo(5)
            make.bottom.equalTo(-3)
            make.right.equalTo(-5)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
