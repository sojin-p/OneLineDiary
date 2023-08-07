//
//  DetailViewController.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {
    
    //Pass Data(값 전달) 1. 데이터를 받을 공간(프로퍼티) 생성
    var contents: String = "빈 공간"
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
        
        //Pass Data(값 전달) 3. 뷰에 표현
//        print(contents)
        resultLabel.text = contents
        resultLabel.textColor = .green
        resultLabel.numberOfLines = 0
    }
    

    @IBAction func deleteButtonClicked(_ sender: UIBarButtonItem) {
        //push - pop (nav가 항상 있어야 동작함)
        navigationController?.popViewController(animated: true)
        
    }
    
}
