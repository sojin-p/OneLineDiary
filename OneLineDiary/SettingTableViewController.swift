//
//  SettingTableViewController.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/08/01.
//

import UIKit

enum SettingOptions: Int, CaseIterable {
    case total, personal, others //섹션 타이틀을 케이스로
    
    //연산 프로퍼티
    var mainOptions: String { //겟 생략가능
        switch self {
        case .total: return "전체 설정"
        case .personal: return "개인 설정"
        case .others: return "기타"
        }
    }
    
    var subOptions: [String] {
        switch self {
        case .total: return ["공지사항", "실험실", "버전 정보"]
        case .personal: return ["개인/보안", "알림", "채팅", "멀티프로필"]
        case .others: return ["고객센터/도움말"]
        }
    }
}

class SettingTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //섹션 갯수
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingOptions.allCases.count
    }
    
    //셀 갯수 0번에 3개, 1번에 4개... 니까
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOptions.allCases[section].subOptions.count
    }
    
    //디자인 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell")!
        
        cell.textLabel?.text = SettingOptions.allCases[indexPath.section].subOptions[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingOptions.allCases[section].mainOptions
    }

   
}
