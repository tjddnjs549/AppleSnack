//
//  ViewController.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/14.
//

import UIKit // Foundation 프레임워크를 내부적으로 import하고 있음

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var data: [String] = ["클래스", "구조체"]
    var selectedIndexPaths: Set<IndexPath> = [] // collection cell를 선택해서 삭제하기 위해서 필요
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var floatingStackView: UIStackView!
    @IBOutlet weak var floatingButton: UIButton!
    @IBOutlet weak var fixButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    lazy var floatingDimView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        view.alpha = 0
        view.isHidden = true
        
        self.view.insertSubview(view, belowSubview: self.floatingStackView)
        
        return view
        
    }()
    
    var isShowFloating: Bool = false
    
    lazy var buttons: [UIButton] = [self.fixButton, self.deleteButton, self.newButton]
    
    
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Lifecycles
        
        // Layout 간격 설정
        
        let flowLayout = UICollectionViewFlowLayout()
        
        
        if let flowLayout = myCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        
        // flowLayout = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        flowLayout.register(Cell.self, forDecorationViewOfKind: "Cell")
        flowLayout.minimumLineSpacing = 0.5 // 셀의 세로 간격
        flowLayout.minimumInteritemSpacing = 0.5 // 셀의 가로 간격
        
        
         flowLayout.itemSize = CGSize(width: 100, height: 50)
         myCollectionView.collectionViewLayout = flowLayout // 기본 세팅
        
        
        // 콜렉션 뷰에 대한 설정
        myCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myCollectionView.dataSource = self
        myCollectionView.delegate = self
        
        
        //        let viewModel = CommentViewModel(comment: comments[IndexPath.row])
        //        let height = viewModel.size(forWidth: view.frame.width).height
        //        return CGSize(width: view.frame.width, height: height)
    }
    
    
    
    // MARK: - FloationgButton
    
    @IBAction func floatingButtonAction(_ sender: UIButton) {
        
        if isShowFloating {
            buttons.reversed().forEach { button in
                UIView.animate(withDuration: 0.3){
                    button.isHidden = true // "편집" 버튼을 눌렀을 때 다시 접히게 해줌
                    self.view.layoutIfNeeded()
                    
                }
            }
            
            UIView.animate(withDuration: 0.5, animations:  {
                self.floatingDimView.alpha = 0
            }) { (_) in
                self.floatingDimView.isHidden = true
            }
        } else {
            self.floatingDimView.isHidden = false
            
            UIView.animate(withDuration: 0.5) {
                self.floatingDimView.alpha = 1
            }
            
            buttons.forEach { [weak self] button in
                button.isHidden = false
                button.alpha = 0
                
                UIView.animate(withDuration: 0.5) {
                    button.alpha = 1
                    self?.view.layoutIfNeeded()
                    
                }
            }
        }
        
        isShowFloating = !isShowFloating
        
        let image = isShowFloating ? UIImage(named: "Hide") : UIImage(named: "Show")
        let roatation = isShowFloating ? CGAffineTransform(rotationAngle: .pi - (.pi / 1)) : CGAffineTransform.identity
        
        UIView.animate(withDuration: 0.3) {
            sender.setImage(image, for: .normal)
            sender.transform = roatation
    
        }
    }

    
    // MARK: - UICollectionViewDataSource
    
    
    // 지정된 섹션에 표시할 셀의 개수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count // 내가 표시할 컬렉션뷰의 개수
    }
    
    // 각 컬렉션뷰 셀에 대한 설정 or 컬렉션 뷰의 지정된 위치에 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 다운케스팅 - 셀의 인스턴스
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! Cell
        
        // 데이터에 따른 UI 변경
        // 라벨 설정
        // cell.Cell.text = self.data[indexPath.item]
        // cell.label.addTarget(self, action: #selector(addCellButtonTapped(_ :)), for: .touchUpInside)
        
        // 배경화면
        cell.contentView.backgroundColor = UIColor.systemBlue
        cell.contentView.layer.cornerRadius = 25
        cell.contentView.layer.borderWidth = 1
        cell.newCell.text = data[indexPath.row] // cell에 입력한 label이 나오게 해줌
        
        cell.configure(text: data[indexPath.item])
        cell.deleteButton.tag = indexPath.item
        cell.deleteButton.addTarget(self, action: #selector(deletButton(_ :)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func addCellButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(item: data.count, section: 0)
        data.append("Cell \(data.count + 1)")
        myCollectionView.insertItems(at: [indexPath])
    }
    // return UICollectionViewCell() // 내가 표시하고자하는 셀
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    private func myCollectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (collectionView.frame.width / 3) - 0.5
        
        return CGSize(width: width, height: width)
        
        if let cell = myCollectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = .green
            print("작동중")
            
            // 셀을 선택했을 때 호출해서 페이지 전환
            //            switch indexPath.item {
            //            // 첫 번째 셀 선택 시, 다른 페이지로 이동하는 동작
            //
            //            case 0:
            //                let nextpageController = NextPageViewController() // 이동할 뷰 컨트롤러 인스턴스 생성
            //                navigationController?.pushViewController(nextpageController, animated: true)
            //
            //            case 1:
            //                // 두 번째 셀 선택 시, 다른 페이지로 이동하는 동작을 구현
            //
            //            default:
            
            //                break
            //            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        // 선택 해제된 셀의 배경색을 원래대로 되돌립니다.
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = .systemBlue
        }
    }
    
    // cell 크기 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
// let text = data[indexPath.item]
// let width = collectionView.bounds.width - 20
        // let height = text.height(withConstrainedWidth: width, font: UIFont.systemFont(ofSize: 10))
        
        return CGSize(width: 100, height: 50)
    }
    // MARK: - alert Button Action
    
    @IBAction func newButton(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "카테고리를 생성합니다.", message: "", preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "입력하세요"
        }
        
        let addAction = UIAlertAction(title: "생성", style: .default) { [weak self, weak alertController] _ in
            if let textField = alertController?.textFields?.first, let text = textField.text, !text.isEmpty {
                self?.data.append(text)
                self?.myCollectionView.reloadData()
                
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    // MARK: - deletButton

    
    @IBAction func deletButton(_ sender: UIButton) {
        
        let index = sender.tag
        
        if index < data.count {
            data.remove(at: index)
            myCollectionView.deleteItems(
                at: [IndexPath(item: index, section: 0)])
        }
        
    }
}
