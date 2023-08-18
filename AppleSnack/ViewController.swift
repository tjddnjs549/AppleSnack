//
//  ViewController.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/14.
//

import UIKit // Foundation 프레임워크를 내부적으로 import하고 있음

class ViewController: UIViewController {
    
    fileprivate var systemImageNameArray = ["클래스", "구조체", "테스트", "일요일"]
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var floatingStackView: UIStackView!
    @IBOutlet weak var floatingButton: UIButton!
    @IBOutlet weak var fixButton: UIButton!
    @IBOutlet weak var deletButton: UIButton!
    
    lazy var floatingDimView: UIView = {
        let view = UIView(frame: self.view.frame)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        view.alpha = 0
        view.isHidden = true
        
        self.view.insertSubview(view, belowSubview: self.floatingStackView)
        
        return view
        
    }()
    
    var isShowFloating: Bool = false
    
    lazy var buttons: [UIButton] = [self.fixButton, self.deletButton]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Lifecycles
        
        // Layout 간격 설정
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 50)
//        myCollectionView.collectionViewLayout = flowLayout // 기본 레이아웃으로 설정?!
        
        
        // 콜렉션 뷰에 대한 설정
        myCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        myCollectionView.dataSource = self
        myCollectionView.delegate = self

        
    }
    
    @IBAction func floatingButtonAction(_ sender: UIButton) {
        
        if isShowFloating {
            buttons.reversed().forEach { button in
                UIView.animate(withDuration: 0.3){
                    button.isHidden = true
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
}
    
    
extension ViewController: UICollectionViewDataSource {
    // 지정된 섹션에 표시할 셀의 개수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.systemImageNameArray.count // 내가 표시할 컬렉션뷰의 개수
        
    }
    
    // 각 컬렉션뷰 셀에 대한 설정 or 컬렉션 뷰의 지정된 위치에 표시할 셀울 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 셀의 인스턴스
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        
        // 배경화면
        cell.contentView.backgroundColor = UIColor.systemBlue
        cell.contentView.layer.cornerRadius = 25
        cell.contentView.layer.borderWidth = 1
        
        // 데이터에 따른 UI 변경
        // 라벨 설정
        cell.mainCollectionViewCell.text = self.systemImageNameArray[indexPath.item]
        
        
        
        return cell
    }
    
    //        return UICollectionViewCell() // 내가 표시하고자하는 셀
}


extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.contentView.backgroundColor = .green
            
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

}

