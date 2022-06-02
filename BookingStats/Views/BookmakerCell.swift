//
//  BookmakerCell.swift
//  BookingStats
//
//  Created by Viacheslav Yakymenko on 01.06.2022.
//

import UIKit
import SnapKit

class BookmakerCell: UICollectionViewCell {
    
    var viewModel: BookmakerCellViewModelType? {
        didSet {
            updateUI()
        }
    }
    
    let statsStackView = UIStackView()
    let resultsContainerView = UIView()
    
    lazy var logo: UIImageView = {
        let view = UIImageView()
        return view
    }()

    lazy var betsCountLabel = UILabel()
    
    lazy var winsLabel = UILabel()
    lazy var winsBar: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    var winsLengthConstraint: Constraint?
    
    lazy var loosesLabel = UILabel()
    lazy var loosesBar: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    var loosesLengthConstraint: Constraint?

    
    lazy var tiesLabel = UILabel()
    lazy var tiesBar: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    var tiesLengthConstraint: Constraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(logo)
        contentView.addSubview(betsCountLabel)
        
        contentView.addSubview(resultsContainerView)
        resultsContainerView.addSubview(winsBar)
        resultsContainerView.addSubview(loosesBar)
        resultsContainerView.addSubview(tiesBar)

        statsStackView.addSubview(winsLabel)
        statsStackView.addSubview(loosesLabel)
        statsStackView.addSubview(tiesLabel)
        
        contentView.addSubview(statsStackView)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowPath = UIBezierPath(rect: contentView.bounds).cgPath
        contentView.layer.backgroundColor = UIColor.white.cgColor
    }
    
    private func setupLayout() {
        
        logo.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(16)
            make.left.equalTo(contentView).offset(16)
            make.height.equalTo(40)
        }
        
        betsCountLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(logo.snp.trailing).offset(16)
            make.bottom.equalTo(logo.snp.bottom)
        }
        
        resultsContainerView.snp.makeConstraints { (make) in
            make.leading.equalTo(contentView).offset(20)
            make.width.equalTo(contentView).offset(-40)
            make.top.equalTo(logo.snp.bottom).offset(16)
            make.bottom.equalTo(contentView).offset(-16)
        }
        
        winsBar.snp.makeConstraints { (make) in
            self.winsLengthConstraint = make.width.equalTo(10).constraint
            make.leading.equalTo(resultsContainerView).offset(-4)
            make.top.equalTo(resultsContainerView)
            make.height.equalTo(8)
        }
        
        loosesBar.snp.makeConstraints { (make) in
            self.loosesLengthConstraint = make.width.equalTo(10).constraint
            make.leading.equalTo(winsBar.snp.trailing).offset(4)
            make.top.equalTo(resultsContainerView)
            make.height.equalTo(8)
        }
        
        tiesBar.snp.makeConstraints { (make) in
            self.tiesLengthConstraint = make.width.equalTo(10).constraint
            make.leading.equalTo(loosesBar.snp.trailing).offset(4)
            make.top.equalTo(resultsContainerView)
            make.height.equalTo(8)
        }
        
        statsStackView.snp.makeConstraints{ (make) in
            make.leading.equalTo(contentView).offset(16)
            make.width.equalTo(contentView).offset(-32)
            make.top.equalTo(resultsContainerView).offset(16)
            make.bottom.equalTo(contentView).offset(-16)
        }
        
        winsLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(winsBar)
        }
        
        loosesLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(loosesBar).priority(.medium)
            make.leading.greaterThanOrEqualTo(winsLabel.snp.trailing).offset(4).priority(.high)
        }
        
        tiesLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(tiesBar)
            make.leading.greaterThanOrEqualTo(loosesLabel.snp.trailing).offset(4)
        }
        
        statsStackView.axis = .horizontal
        statsStackView.alignment = .fill
        statsStackView.distribution = .fill
    }
    
    private func updateUI() {
        guard let viewModel = viewModel else {
            return
        }
        
        logo.image = viewModel.logo
        betsCountLabel.text = viewModel.betsCountDescription
        
        winsLabel.attributedText = viewModel.winsDescription
        loosesLabel.attributedText = viewModel.loosesDescription
        tiesLabel.attributedText = viewModel.tiesDescription
        
        logo.snp.makeConstraints { (make) in
            var imageRatio: Float?
            if let image = logo.image {
                imageRatio = Float(image.size.width) / Float(image.size.height)
            }
            make.width.equalTo(logo.snp.height).multipliedBy(imageRatio ?? 0)
        }
        
        winsLengthConstraint?.deactivate()
        winsBar.snp.makeConstraints { (make) in
            self.winsLengthConstraint = make.width.equalTo(resultsContainerView.snp.width).multipliedBy(viewModel.winsShare).constraint
        }
        
        loosesLengthConstraint?.deactivate()
        loosesBar.snp.makeConstraints { (make) in
            self.loosesLengthConstraint = make.width.equalTo(resultsContainerView.snp.width).multipliedBy(viewModel.loosesShare).constraint
        }
        
        tiesLengthConstraint?.deactivate()
        tiesBar.snp.makeConstraints { (make) in
            self.tiesLengthConstraint = make.width.equalTo(resultsContainerView.snp.width).multipliedBy(viewModel.tiesShare).constraint
        }
        
    }
    
    override func prepareForReuse() {
        logo.image = nil
    }
}
