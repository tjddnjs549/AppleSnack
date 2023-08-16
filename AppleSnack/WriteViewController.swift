//
//  WriteViewController.swift
//  AppleSnack
//
//  Created by 박성원 on 2023/08/16.
//

// 1. 텍스트 필드를 다 쓰소 다음을 누르면 아래로 커서 이동 (o)
// 2. 키보드 높이만큼 화면도 올라가기 (o)
// 3. titleTextField(텍스트필드)가 비어있으면 저장 못하게 하기 -> alert창으로 알려주기 (o)
// 5. 가져와서
// 6. -> create
// 7. -> update
// 8.


import UIKit



class WriteViewController: UIViewController {

    
    @IBOutlet weak var myScroll: UIScrollView!
    
    @IBOutlet weak var scrollView: UIView!
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contextTextView: UITextView!
    
    @IBOutlet weak var urlTextView: UITextView!
    
    
    var mySnack: MySnack?
    
    var snackManager = SnackManager.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNaviBar()
        configureUI()
        setup()
        scrollViewTapped()
        scrollMoveKeyboard()
    }
    
    // MARK: - setup() 세팅 (테두리)

    
    private func setup() {
        contextTextView.delegate = self
        urlTextView.delegate = self
        titleTextField.delegate = self
        
        contextTextView.layer.borderWidth = 1.0
        contextTextView.layer.borderColor = UIColor.lightGray.cgColor
        contextTextView.layer.cornerRadius = 12
        
        urlTextView.layer.borderWidth = 1.0
        urlTextView.layer.borderColor = UIColor.lightGray.cgColor
        urlTextView.layer.cornerRadius = 12
        
        titleTextField.layer.borderWidth = 1.0
        titleTextField.layer.cornerRadius = 12
        titleTextField.layer.borderColor = UIColor.lightGray.cgColor
        titleTextField.clearButtonMode = .always //오른쪽에 'x' 버튼
        titleTextField.returnKeyType = .next //리턴 버튼 수정
        titleTextField.becomeFirstResponder()
    }
    
    // MARK: - configureUI() (bar title , placeholder setting)

    private func configureUI() {
        
        // 기존에 데이터가 있을때
        if let mySnack = self.mySnack {
            self.title = "수정 페이지"
            
            guard let text = mySnack.title, let context = mySnack.text, let url = mySnack.assiURL else { return }
      
            titleTextField.text = text
            contextTextView.text = context
            urlTextView.text = url
            
        // 기존데이터가 없을때
        } else {
            self.title = "생성 페이지"
            
            contextTextView.text = "내용을 입력하세요."
            contextTextView.textColor = .lightGray

            urlTextView.text = "도움이 될 만한 주소를 입력하세요."
            urlTextView.textColor = .lightGray
        }
    }
    
  
    
    // MARK: - 네비게이션 바 설정
    
    private func setupNaviBar() {
        
        self.title = "글 추가"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        
    
        
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
        
        doneButton.tintColor = .orange
        navigationItem.rightBarButtonItem = doneButton
        
        let backButton = UIBarButtonItem(title: "뒤로", style: .done, target: self, action: #selector(backButtonTapped))
        
        backButton.tintColor = .orange
        navigationItem.leftBarButtonItem = backButton
    }
    
    // MARK: - 완료버튼 누르면 이벤트 함수

    @objc func doneButtonTapped() {
        
        let titleTextField = titleTextField.text
        
        //만약 타이틀이 빈값이면
        if (titleTextField!.isEmpty) {
            titleIsEmptyAlertMessage()
            return
        } else { // 빈값이 아니면 이동
            if let mySnack = self.mySnack {
                mySnack.title = titleTextField
                mySnack.text = contextTextView.text
                mySnack.assiURL = urlTextView.text
                snackManager.updateToDo(newSnackData: mySnack) {
                    print("업데이트 완료")
                    // 다시 전화면으로 돌아가기
                    self.navigationController?.popViewController(animated: true)
                }
            } else {
                let title = titleTextField
                let text = contextTextView.text
                let assiURL = urlTextView.text
//                snackManager.saveToDoData(title: title, text: text, photo: <#T##Data?#>, categorie: <#T##String?#>, assiUrl: assiURL)
                print("생성 완료")
                //다시 전화면으로 돌아가기
//                guard let viewControllerStack = self.navigationController?.viewControllers else { return }
//                        for viewController in viewControllerStack {
//                          if let "2번째View" = viewController as? "2번째ViewController" {
//                                self.navigationController?.popToViewController("2번째View", animated: true)
//                }
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
    
    private func scrollViewTapped() {

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        
        scrollView.addGestureRecognizer(recognizer)
     }
    
    @objc func touch() {
        self.view.endEditing(true)
    }
    
    
    // MARK: - scrollMoveKeyboard() (스크롤뷰에서 키보드 올림과 내림에서 화면 커짐)

    
    func scrollMoveKeyboard() {
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else {
          // if keyboard size is not available for some reason, dont do anything
          return
        }

        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height , right: 0.0)
        myScroll.contentInset = contentInsets
        myScroll.scrollIndicatorInsets = contentInsets
      }

      @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
            
        
        // reset back the content inset to zero after keyboard is gone
          myScroll.contentInset = contentInsets
          myScroll.scrollIndicatorInsets = contentInsets
      }
   
    
}

// MARK: - UITextViewDelegate


extension WriteViewController: UITextViewDelegate {
    
    //텍스트뷰 플레이스 홀더
    // 입력을 시작할때
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "여기에 입력하세요." {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 입력이 끝났을때
    func textViewDidEndEditing(_ textView: UITextView) {
        // 비어있으면 다시 플레이스 홀더처럼 입력하기 위해서 조건 확인
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = "여기에 입력하세요."
            textView.textColor = .lightGray
        }
    }
}


// MARK: - UITextFieldDelegate

extension WriteViewController: UITextFieldDelegate {
   
    //제목에서 키보드 다음버튼 누르면 아래 텍스트뷰(내용칸)으로 커서 이동
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.titleTextField {
            self.contextTextView.becomeFirstResponder()
        }
        return true
    }
}

