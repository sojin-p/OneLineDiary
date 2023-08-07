//
//  ViewController.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

//한번은 추가화면, 한번은 수정화면으로 쓰고싶다
enum TransitionType: String {
    case add = "추가 화면"
    case edit = "수정 화면"
}

//1. 부하(프로토콜) 부르기 UITextViewDelegate
//2. 아웃렛 연결
//3. resultTextView.delegate = self
//4. 필요한 메서드(프로토콜) 호출해서 구현하기
class AddViewController: UIViewController, UITextViewDelegate { //1. 텍뷰 부하 부르기
    //2. 아웃렛 연결
    @IBOutlet var resultTextView: UITextView!
    
    var type: TransitionType = .add
    
    //받을 그릇 준비. 의미없는 빈 문자열 초기화하는 것 보다 옵셔널 주는 게 목적에 더 맞다.
    var contents: String = "" //위를 애드로 해놔서.add일 때는 빈 문자열 준다고 기본

    //placeholder
    let placeholerText = "내용을 입력해주세요."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //3. 아웃렛과 딜리게이트 연결해라(왜 연결? 텍뷰를 여러개 놓고 다른기능 구현 할 수도 있으니까)
        resultTextView.delegate = self
        
        resultTextView.text = contents //위에 add일 때 빈 문자열 준다고 했기 때문에 스위치문에서 빼옴
        title = type.rawValue //얘도 마찬가지(로우밸류 주고 빼기)
        
        switch type {
        case .add:

            let xmark = UIImage(systemName: "xmark")
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked)) //target은 어디있는건지.. 보통 자기거에 있어서 99.9%는 셀프
            
            navigationItem.leftBarButtonItem?.tintColor = .black//코드 순서 중요
            
            resultTextView.text = placeholerText
            resultTextView.textColor = .lightGray
            
        case .edit: print("프린트")

        }
        
        setBackgroundColor() //익스텐션(공통으로 줄만한것들 모아놓기) 함수 불러오기

        
    }
    
    //글자가 바뀌고 나서의 액션
    func textViewDidChange(_ textView: UITextView) {
        print(textView.text.count)
        title = "\(textView.text.count)글자"
    }
    
    //편집이 시작될 때 (커서가 시작될 때)
    //플레이스 홀더와 텍스뷰 글자가 같다면 clear, color
    func textViewDidBeginEditing(_ textView: UITextView) {
//        print(#function)
        if textView.text == placeholerText {
            textView.text = nil //플레이스홀더 문구가 남아있으면 안되니까
            textView.textColor = .black
        }
    }
    
    //편집이 끝날 때(커서가 없어지는 순간)
    //사용자가 아무 글자도 안썼으면 플레이스 홀더 글자 보이게 설정!
    func textViewDidEndEditing(_ textView: UITextView) {
//        print(#function)
        if textView.text.isEmpty {
            textView.text = placeholerText
            textView.textColor = .lightGray
        }
    }
    
    
    @objc
    func closeButtonClicked() {
        //present - dismiss / push - pop으로 사라지기
        dismiss(animated: true)
        
//        //pop 코드
//        navigationController?.popViewController(animated: true)
    }


}

