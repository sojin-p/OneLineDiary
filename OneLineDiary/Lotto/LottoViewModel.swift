//
//  LottoViewModel.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/09/13.
//

import Foundation

class LottoViewModel {
    
    var num1 = Observable("1")
    var num2 = Observable("2")
    var num3 = Observable("3")
    var num4 = Observable("4")
    var num5 = Observable("5")
    var num6 = Observable("6")
    var bnusNum = Observable("7")
    var lottoMoney = Observable("당첨금")
    
    var list: [Int] = Array(1...1084).reversed()
    //역순으로! reversed를 쓰면 타입이 달라질 수 있으므로 타입어노테이션으로 명확하게 해줘야 에러안남!
    //Array(repeating: 100, count: 10)
    
    func format(for number: Int) -> String {
        let numberFormat = NumberFormatter()
        numberFormat.numberStyle = .decimal
        return numberFormat.string(for: number)!
    }
    
    var componentCount: Int {
        list.count
    }
    
    func titleForRow(_ row: Int) -> String {
        return "\(list[row])"
    }
    
    func didSelectRow(_ row: Int) -> () {
        return callLotto(num: list[row])
    }
    
    func callLotto(num: Int) {
        
        APIManager.shared.callRequest(num: num) { data in

            self.num1.value = String(data.drwtNo1)
            self.num2.value = String(data.drwtNo2)
            self.num3.value = String(data.drwtNo3)
            self.num4.value = String(data.drwtNo4)
            self.num5.value = String(data.drwtNo5)
            self.num6.value = String(data.drwtNo6)
            self.bnusNum.value = String(data.bnusNo)
            self.lottoMoney.value = "1등 당첨 금액은 \(self.format(for: data.firstWinamnt))원 입니다!"
            
        }
    }
    
}
