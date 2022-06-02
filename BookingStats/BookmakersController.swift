//
//  ViewController.swift
//  BookingStats
//
//  Created by Viacheslav Yakymenko on 01.06.2022.
//

import UIKit
import SnapKit
import RxSwift

class BookmakersController: UIViewController {

    private let bag = DisposeBag()
    private var viewModel: BookmakersListViewModelType?
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Выигрыши/проигрыши по букмейкерам"
        view.backgroundColor = .white
                
        let layout = UICollectionViewFlowLayout()
        layout.sectionInsetReference = .fromSafeArea
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionView ?? UICollectionView())
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.register(BookmakerCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView?.snp.makeConstraints{ (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        viewModel = BookmakersListViewModel()
        
        bindUI()
    }
    
    private func bindUI() {
        viewModel?.bookmakers.asDriver().drive(onNext: { [weak self] _ in
            self?.collectionView?.reloadData()
        })
            .disposed(by: bag)
    }
 
}

//MARK: - Collection view data source & delegate
extension BookmakersController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.bookmakersCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! BookmakerCell
        let cellViewModel = viewModel?.cellViewModel(for: indexPath.row)
        cell.viewModel = cellViewModel
        return cell
    }
}

//MARK: - Collection view layout
extension BookmakersController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.frame.width - 32, height: 112)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
}
