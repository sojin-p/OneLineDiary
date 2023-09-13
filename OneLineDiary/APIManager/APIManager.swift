//
//  APIManager.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/09/13.
//

import Foundation
import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    private init() { }
    
    func callRequest(num: Int, completion: @escaping (Lotto) -> Void) {
        
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(num)"
        
        AF.request(url, method: .get).validate()
            .responseDecodable(of: Lotto.self) { response in
                
                switch response.result {
                case .success(let value):
                    print("오는지: \(value)")
                    completion(value)
                    
                case .failure(let error):
                    print(error)
                }
                
            }
        
    }
    
//    func callReauest(num: Int, completion: @escaping () -> Void) { //getLotto 등등
//        //1. 임폴트 먼저하고, url에 링크 넣기! Or 상수로 만들어서 처리
//        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(num)"
//        //2. Alamofire를 AF로 바꾸기 - 리퀘스트(서버한테 요청)는 알라모, 리스폰스(응답)는 제이슨이 담당
//        //3. validate괄호 지우고 다시 열어보기 200...399까지를 성공으로 하겠다면 적어넣고, 괄호비어있으면 200~299가 성공인것
//        AF.request(url, method: .get).validate().responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value) //괄호부터 괄호. 딕셔너리라 키에따른 밸류..(오타주의) 타입 추론을..
//                print("JSON: \(json)")
//                print("3") //리퀘스트가 얼마나 걸릴줄알고..(동기/비동기)
//                //실행은 시켜놨는데, 그 와중에 뷰딛롣 다른코드도 실행이 된 것 (콜백메서드)
//
//                let date = json["drwNoDate"].stringValue
//                let bonusNumber = json["bnusNo"].intValue
//
//                for (index, i) in self.numberCollection.enumerated() {
//                    let num = json["drwtNo\(index + 1)"].intValue
//                    i.text = "\(num)"
//                }
//
//                self.dateLabel.text = date //클로저,,라서인지 셀프를..붙이는..?
//                self.bonusNumberLabel.text = "\(bonusNumber)"
//
//            case .failure(let error): //긴급점검 한다던지, 인터넷이 안된다던지
//                print(error)
//            }
//        }
//    }
    
}
