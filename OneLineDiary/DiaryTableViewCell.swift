//
//  DiaryTableViewCell.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class DiaryTableViewCell: UITableViewCell {
    
    static let identifier = "DiaryTableViewCell" //한 공간에서만 쓸 수 있게 스태틱, 스태틱 안쓰면 오류남

    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var backView: UIView!
    
    
}
