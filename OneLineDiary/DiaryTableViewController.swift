//
//  DiaryTableViewController.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/07/31.
//

import UIKit

class DiaryTableViewController: UITableViewController {
    
    var list = ["테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1테스트1", "테스트2", "테스트3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundColor()
//        tableView.backgroundColor = .clear
        
        //XIB로 셀 생성할 경우, 테이블뷰에 사용할 셀을 등록해주는 과정이 필요!(화면이 뜨기전에 해야하므로 뷰디드로드)
        //번들 nil로 설정하면 메인 번들(내 프로젝트 경로, 내건 알아서 코드 짜여있음)이 연결됨
        let nib = UINib(nibName: DiaryTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: DiaryTableViewCell.identifier)
        
        //Dynamic Height(자동 높이 조절):
        //1. automaticDimension / 2. numberOfLines = 0 / 3. AutoLayout(여백)
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    @IBAction func searchBarButtonClicked(_ sender: UIBarButtonItem) {
        
        //search아이콘 클릭시 SearchCollectionViewController Push!
//        let sb = UIStoryboard(name: "Main", bundle: nil)
        //밑 코드에서 처음 sb.을 storyboard?로. 단, 같은 스토리보드 안에 있다는 전제하에!!!
        let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchCollectionViewController") as! SearchCollectionViewController
        
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    @IBAction func addBarButtonClicked(_ sender: UIBarButtonItem) {
        
        //1. 스토리보드 파일 찾기
        let sb = UIStoryboard(name: "Main", bundle: nil)
        //2. 스토리보드 파일 내 뷰컨트롤러 찾기(어떤 스토리보드 안에 있나)
        let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        //5. 같은 화면을 분리할 때
        vc.type = .add
        
        //2-1. 네비게이션 컨트롤러(제목바) 붙여서 present 하고 싶을 때(옵션)
        //nav를 사용한다면 present와 화면 전환 방식도 nav로 수정해야 함 - 오류 많이 뜬다..
        let nav = UINavigationController(rootViewController: vc)
        
        //3. 화면 전환 방식 설정(옵션) - vc.tra
//        vc.modalTransitionStyle = .crossDissolve //모달 애니메이션
        nav.modalPresentationStyle = .fullScreen //모달 방식
        //4. 화면 띄우기
        present(nav, animated: true) //modal
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    //디자인, 데이터
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DiaryTableViewCell.identifier) as? DiaryTableViewCell else {
            return UITableViewCell() //닐이면 빈 셀 보여줘(클래스의 인스턴스 초기화 한 것)
            
        }
        
        cell.contentLabel.text = list[indexPath.row]
        cell.contentLabel.numberOfLines = 0
//        cell.backgroundColor = .clear
        
        return cell
    }
    
    //1. 편집 상태로 만들기 - 키워드 : cane
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true //편집 상태로 만들겠다(어떤 셀은 편집 상태를 안 주고 싶을 수 있으니까)
    }
    
    //2. 삭제 스타일 - comm
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //삭제하는 코드 자유롭게.. 알림창을 띄우던 바로 삭제를 시키던 코드로 구현~!
        
        list.remove(at: indexPath.row)
        tableView.reloadData()
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("되나")
        //DetailViewController 생성해서 present 해보기!
        let sb = UIStoryboard(name: "Main", bundle: nil)
//        let detailVC = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        //추가컨트롤러
        let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        //Pass Data(값 전달) 2. 뷰컨이 가지고있는 프로퍼티에 데이터 추가
//        detailVC.contents = "Diary 뷰컨에서 데이터 전달하면서 화면 전환 하기!!"
        
        vc.type = .edit

        vc.contents = list[indexPath.row]
        
        //값 전달 시 아웃렛을 활용할 수 없음 - 이유 : 결과레이블보다 콘텐츠가 더 빨리 만들어져서.. 레이블이 없는데 어떻게 넣냐는 것
//        detailVC.resultLabel.text = list[indexPath.row]
        
        //네비컨트롤러가 없을 수도 있어서 옵셔널 붙음
        //인터페이스 빌더에 네비게이션 컨트롤러가 임베드 되어 있어야만 Push가 동작함
        navigationController?.pushViewController(vc, animated: true) //show
        
    }
    
//    // 왼쪽 커스텀 스와이프 - lea
//    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        UISwipeActionsConfiguration(actions: <#T##[UIContextualAction]#>) //스와이프 요소(딜리트같은)가 여러 개면 배열이기 때문에 기본형태가 배열,,
//
//    }
//
//
//    // 오른쪽 커스텀 스와이프 - trail
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        <#code#>
//    }
  
}
