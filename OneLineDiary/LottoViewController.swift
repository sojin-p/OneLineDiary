//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/08/03.
//

import UIKit
import Alamofire
import SwiftyJSON

class LottoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var bonusNumberLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    let pickerView = UIPickerView()
    
    var list: [Int] = Array(1...1079).reversed() //역순으로! reversed를 쓰면 타입이 달라질 수 있으므로 타입어노테이션으로 명확하게 해줘야 에러안남!
    //Array(repeating: 100, count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("1")
        print("2")
        
        callReauest(num: 1079)

        print("4")
        
        //원래 텍필의 인풋뷰는 키보드인데 이걸 피커로 바꾸는 것
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear //커서 안보이게
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        print("5")

    }
    
    func callReauest(num: Int) { //getLotto 등등
        //1. 임폴트 먼저하고, url에 링크 넣기! Or 상수로 만들어서 처리
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(num)"
        //2. Alamofire를 AF로 바꾸기 - 리퀘스트(서버한테 요청)는 알라모, 리스폰스(응답)는 제이슨이 담당
        //3. validate괄호 지우고 다시 열어보기 200...399까지를 성공으로 하겠다면 적어넣고, 괄호비어있으면 200~299가 성공인것
        AF.request(url, method: .get).validate().responseJSON { response in //in..? 클로저 문법
            switch response.result {
            case .success(let value):
                let json = JSON(value) //괄호부터 괄호. 딕셔너리라 키에따른 밸류..(오타주의) 타입 추론을..
                print("JSON: \(json)")
                print("3") //리퀘스트가 얼마나 걸릴줄알고..(동기/비동기)
                //실행은 시켜놨는데, 그 와중에 뷰딛롣 다른코드도 실행이 된 것 (콜백메서드)
                
                let date = json["drwNoDate"].stringValue
                let bonusNumber = json["bnusNo"].intValue
                
                print(date, bonusNumber)
                self.dateLabel.text = date //클로저,,라서인지 셀프를..붙이는..?
                self.bonusNumberLabel.text = "\(bonusNumber)번"
                
            case .failure(let error): //긴급점검 한다던지, 인터넷이 안된다던지
                print(error)
            }
        }
    }
    
    //컴포넌트: 휠로 돌리는 것의 갯수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //그 컴포넌트 안에 셀 몇개 넣을거야
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    //셀의 타이틀
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { //커스텀 가능해서 옵셔널임
        return "\(list[row])"
    }
    
    //휠이 멈춰서 밸류가 바뀌었다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(list[row])")
        numberTextField.text = "\(list[row])"
        callReauest(num: list[row])
    }

}
