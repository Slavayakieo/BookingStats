//
//  BookmakersListViewModel.swift
//  BookingStats
//
//  Created by Viacheslav Yakymenko on 01.06.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol BookmakersListViewModelType {
    var bookmakers: BehaviorRelay<[InputData]> { get }
    var bookmakersCount: Int { get }
    
    func cellViewModel(for row: Int) -> BookmakerCellViewModelType
}

class BookmakersListViewModel: BookmakersListViewModelType {
    var dummyData = [InputData()]
    var bookmakers: BehaviorRelay<[InputData]>
    
    var bookmakersCount: Int {
        return bookmakers.value.count
    }
    
    func cellViewModel(for row: Int) -> BookmakerCellViewModelType {
        return BookmakerCellViewModel(bookingData: bookmakers.value[row])
    }
    
    init() {
        bookmakers = BehaviorRelay<[InputData]>(value: dummyData)
    }
}
