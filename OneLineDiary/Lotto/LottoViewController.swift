//
//  LottoViewController.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/08/03.
//

import UIKit

class LottoViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var numberCollection: [UILabel]!
    
    @IBOutlet var bonusNumberLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    let pickerView = UIPickerView()
    let viewModel = LottoViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.callLotto(num: 1084)
        
        bindData()
        
        //원래 텍필의 인풋뷰는 키보드인데 이걸 피커로 바꾸는 것
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear //커서 안보이게
        
        pickerView.delegate = self
        pickerView.dataSource = self

    }
    
    func bindData() {
        
        viewModel.num1.bind { value in
            self.numberCollection[0].text = value
        }
        
        viewModel.num2.bind { value in
            self.numberCollection[1].text = value
        }
        
        viewModel.num3.bind { value in
            self.numberCollection[2].text = value
        }
        
        viewModel.num4.bind { value in
            self.numberCollection[3].text = value
        }
        
        viewModel.num5.bind { value in
            self.numberCollection[4].text = value
        }
        
        viewModel.num6.bind { value in
            self.numberCollection[5].text = value
        }
        
        viewModel.bnusNum.bind { value in
            self.bonusNumberLabel.text = value
        }
        
        viewModel.lottoMoney.bind { value in
            self.dateLabel.text = value
        }
        
    }
   
    //컴포넌트: 휠로 돌리는 것의 갯수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //그 컴포넌트 안에 셀 몇개 넣을거야
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.componentCount
    }
    
    //셀의 타이틀
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? { //커스텀 가능해서 옵셔널임
        return viewModel.titleForRow(row)
    }
    
    //휠이 멈춰서 밸류가 바뀌었다.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print("\(list[row])")
        numberTextField.text = viewModel.titleForRow(row)
        viewModel.didSelectRow(row)
//        callReauest(num: list[row])
    }

}
