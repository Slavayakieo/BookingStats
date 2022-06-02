//
//  BookmakerCellViewModel.swift
//  BookingStats
//
//  Created by Viacheslav Yakymenko on 01.06.2022.
//

import UIKit

protocol BookmakerCellViewModelType {
    var logo: UIImage? { get }
    var betsCountDescription: String { get }

    var winsShare: Float { get }
    var loosesShare: Float { get }
    var tiesShare: Float { get }
    
    var winsDescription: NSAttributedString { get }
    var loosesDescription: NSAttributedString { get }
    var tiesDescription: NSAttributedString { get }
}

class BookmakerCellViewModel: BookmakerCellViewModelType {

    var bookingData: InputData
    
    var logo: UIImage? {
        return bookingData.logo
    }
    
    private var betsCount: Int {
        bookingData.wins + bookingData.looses + bookingData.ties
    }
    
    var betsCountDescription: String {
        let count = betsCount
        var countString: String
        switch count % 10 {
        case 1:
            countString = "ставка"
        case 2, 3, 4:
            countString = "ставки"
        case 5, 6, 7, 8, 9, 0:
            countString = "ставок"
        default:
            countString = "ставки"
        }
        
        let specialRange = 11...14
        if specialRange.contains(count % 100) {
            countString = "ставок"
        }

        return "\(betsCount) \(countString)"
    }
    
    var winsShare: Float {
        return percentage(for: bookingData.wins)
    }
    
    var loosesShare: Float {
        return percentage(for: bookingData.looses)
    }
    
    var tiesShare: Float {
        return percentage(for: bookingData.ties)
    }
    
    var winsDescription: NSAttributedString {
        let percentage = Int(round(winsShare * 100))
        return NSAttributedString(string: "\(bookingData.wins) (\(percentage)%)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14) ])    }
    
    var loosesDescription: NSAttributedString {
        let percentage = Int(round(loosesShare * 100))
        return NSAttributedString(string: "\(bookingData.looses) (\(percentage)%)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14) ])
    }
    
    var tiesDescription: NSAttributedString {
        let percentage = Int(round(tiesShare * 100))
        return NSAttributedString(string: "\(bookingData.ties) (\(percentage)%)", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14) ])
    }
    
    init(bookingData: InputData) {
        self.bookingData = bookingData
    }

    private func percentage(for value: Int) -> Float {
        return Float(value) / Float(betsCount)
    }
}
