//
//  SearchCollectionViewController.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class SearchCollectionViewController: UICollectionViewController {
    
    let searchBar = UISearchBar() //네비에 인풋으로 넣을거라 이렇게 가능
    
    let list = ["iOS", "iPad", "Android", "Apple", "Watch", "사과", "사자", "호랑이"]
    var searchList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self //2.연결
        
        searchBar.placeholder = "검색어를 입력해주세요."
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        
        let nib = UINib(nibName: "SearchCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        
        setCollectionViewLayout()

    }
    
    //3.
    func setCollectionViewLayout() {
        //cell estimated size none 으로 인터페이스 빌더에서 설정할 것!!!
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 10 //주고 싶은 여백. 타입어노테이션~!
        let width = UIScreen.main.bounds.width - (spacing * 4) //main은 16까지 쓸수있음..ㅠ
        
        
        layout.itemSize = CGSize(width: width / 3, height: width / 3) //3개 놓고 싶을 때
        
        //디바이스와의 상하좌우 여백
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        
        //사이사이 여백(최소한의 간격)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        //레이아웃 교체를 해달라
        collectionView.collectionViewLayout = layout
    }
    
    //1. row 대신 item 갯수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    //2. 데이터, 디자인
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        
        cell.backgroundColor = .yellow
        cell.contentsLabel.text = searchList[indexPath.item]
        
        return cell
    }

}

extension SearchCollectionViewController: UISearchBarDelegate { //1.부하부르기
    
    //리턴키 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("함수실행되나!?")
        searchList.removeAll()//키를 누르면 나머지가 지워져야하니까!
        
        for item in list {
            if item.contains(searchBar.text!) {
                searchList.append(item)
//                print(searchList)
            }
        }
        collectionView.reloadData()
        
    }
    
    //취소버튼
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchList.removeAll()
        collectionView.reloadData()
    }
    
    //글자가 바뀔 때마다(실시간 검색어)
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchList.removeAll()
        
        for item in list {
            if item.contains(searchBar.text!) {
                searchList.append(item)
            }
        }
        collectionView.reloadData()
        
    }
}
