//
//  WriteViewController.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/16.

import UIKit


final class WriteViewController: UIViewController {
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contextTextView: UITextView!
    @IBOutlet weak var urlTextView: UITextView!
    
    var mySnack: MySnack?
    var snackNumber = 0
    var snackManager = SnackManager.shared
    var category: String?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupNaviBar()
        setup()
        setupKeyboardEvent()
    }
        
    
    // MARK: - configureUI() (bar title , placeholder setting)
    
    private func configureUI() {
        
        // 기존에 데이터가 있을때
        if let mySnack = mySnack {
            
            self.title = "수정 페이지"
            
            titleTextField.text = mySnack.title
            contextTextView.text = mySnack.text
            urlTextView.text = mySnack.assiURL
            
        }
        // 기존데이터가 없을때
        else {
            self.title = "생성 페이지"
            
            titleTextField.textColor = .lightGray
            
            contextTextView.text = "내용을 입력하세요."
            contextTextView.textColor = .lightGray
            
            urlTextView.text = "도움이 될 만한 주소를 입력하세요."
            urlTextView.textColor = .lightGray
        }
    }
    
    // MARK: - 네비게이션 바 설정
    
    private func setupNaviBar() {
        
        
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
        
        navigationItem.rightBarButtonItem = doneButton
        
        let backButton = UIBarButtonItem(title: "뒤로", style: .done, target: self, action: #selector(backButtonTapped))

        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - 완료버튼 누르면 이벤트 함수
    
    @objc func doneButtonTapped() {
        
        //만약 타이틀이 빈값이면
        if titleTextField.hasText != true {
            titleIsEmptyAlertMessage()
            return
        } else { // 빈값이 아니면 이동
            if let mySnack = self.mySnack {
                mySnack.title = titleTextField.text
                mySnack.text = contextTextView.text
                mySnack.assiURL = urlTextView.text
                snackManager.updateSnack(newSnackData: mySnack) {
                    print("업데이트 완료")
                    let storyboard = UIStoryboard(name: "DetailViewStoryboard", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewStoryboard") as! DetailViewController
                    vc.mySnack = mySnack
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else {
                snackManager.saveToSnack(title: titleTextField.text, text: contextTextView.text, categorie: category, assiUrl: urlTextView.text) {
                    print("생성 완료")
                    NotificationCenter.default.post(name: NSNotification.Name("RequestProgressUpdate"), object: nil)
                    let storyboard = UIStoryboard(name: "SnackList", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "SnackList") as! SnackListController
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            }
        }
    }
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - 제목 비어있으면 alert 창
    
    private func titleIsEmptyAlertMessage() {
        
        let alert = UIAlertController(title: "제목이 비었습니다", message: "제목을 입력해야 완료가 됩니다", preferredStyle: .alert)
        // UIAlertController를 통해 alert 창을 만듬/ preferredStyle: alert창이 어떻게 나오는지 설정
        let success = UIAlertAction(title: "확인", style: .default) { action in
            print("확인 버튼이 눌렀습니다.")
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            print("취소 버튼이 눌렀습니다.")
        }
        alert.addAction(success) //addSubview랑 같은 것
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil) // 보여지게 함
    }
    
    // MARK: - scrollViewTapped() (스크롤뷰에서 다른 곳 터치 시 키보드 내림)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    // MARK: - setupKeyboardEvent() (뷰에서 키보드 올림과 내림에서의 화면)
    
    func setupKeyboardEvent() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(_ sender: Notification) {
        // keyboardFrame: 현재 동작하고 있는 이벤트에서 키보드의 frame을 받아옴
        // currentTextField: 현재 응답을 받고있는 UITextField를 알아냅니다.
        guard let keyboardFrame = sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextView = UIResponder.currentResponder as? UITextView else { return }
        
        // Y축으로 키보드의 상단 위치
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        // 현재 선택한 텍스트 필드의 Frame 값
        let convertedTextViewFrame = view.convert(currentTextView.frame,
                                                  from: currentTextView.superview)
        // Y축으로 현재 텍스트 필드의 하단 위치
        let textFieldBottomY = convertedTextViewFrame.origin.y + convertedTextViewFrame.size.height
        
        // Y축으로 텍스트필드 하단 위치가 키보드 상단 위치보다 클 때 (즉, 텍스트필드가 키보드에 가려질 때가 되겠죠!)
        if textFieldBottomY > keyboardTopY {
            let textFieldTopY = convertedTextViewFrame.origin.y
            // 노가다를 통해서 모든 기종에 적절한 크기를 설정함.
            let newFrame = textFieldTopY - keyboardTopY/1.17
            view.frame.origin.y -= newFrame
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}





