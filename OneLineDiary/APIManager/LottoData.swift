//
//  LottoData.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/09/13.
//

import Foundation

// MARK: - Lotto
struct Lotto: Codable {
    let drwNo: Int
    let drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6, bnusNo: Int
    let drwNoDate: String
    let firstWinamnt: Int
}
