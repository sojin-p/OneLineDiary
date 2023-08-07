//
//  TimelineViewController.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/08/02.
//

import UIKit
/*
 1. 프로토콜(부하직원) UICollectionViewDelegate, UICollectionViewDataSource
 2. 컬렉션 뷰에 대한 아웃렛 선언(컬렉션 뷰가 여러개 들어갈 수 있으니까)
 3. 컬렉션 뷰와 부하직원을 연결 : delegate = self (타입으로써 프로토콜 사용)
 */


//클래스에 상속은 한번에 하나만 됨
//: 바로 뒤는 상속이고 쉼표찍은 다음은 프로토콜로 부하 부른 것
class TimelineViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //2.
    @IBOutlet var todayCollectionView: UICollectionView!
    @IBOutlet var bestCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //3.
        todayCollectionView.delegate = self
        todayCollectionView.dataSource = self
        
        bestCollectionView.delegate = self
        bestCollectionView.dataSource = self
        
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        todayCollectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        bestCollectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")//베스트컬렉션 뷰에 위 셀 재활용
        
        configureCollectionViewLayout()
        configureBestCollectionViewLayout()

    }
    
    func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal //수평 스크롤
        layout.itemSize = CGSize(width: 100, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        todayCollectionView.collectionViewLayout = layout
    }
    
    func configureBestCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 180) //배너 하나씩 넘기듯
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        bestCollectionView.collectionViewLayout = layout
        
        //자석처럼 붙는 것(셀마다 페이지를 같이..) 근데 디바이스 너비만큼만 페이징 됨 width를 300해도..
        bestCollectionView.isPagingEnabled = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if collectionView == todayCollectionView {
//            return 3
//        } else {
//            return 10
//        }
        
        return collectionView == todayCollectionView ? 3 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        
        if collectionView == todayCollectionView {
            cell.contentsLabel.text = "Today: \(indexPath.item)"
            cell.backgroundColor = .cyan
        } else {
            cell.contentsLabel.text = "Best: \(indexPath.item)"
            cell.backgroundColor = [.blue, .yellow, .red, .black].randomElement()
        }
        
        return cell
    }

}
