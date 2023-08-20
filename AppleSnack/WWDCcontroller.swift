

import UIKit
import WebKit

class WWDCcontroller: UIViewController {
    
    var cookieStore: WKHTTPCookieStore!
    
    let year: UICollectionView = {
        
        let flowLayout = UICollectionViewFlowLayout()
        
        let itemSize = (UIScreen.main.bounds.width - Collection.spacingWitdh * (Collection.cellColumns - 1)) / Collection.cellColumns
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 100, height: 40)
        flowLayout.minimumLineSpacing = Collection.spacingWitdh
        //        flowLayout.minimumInteritemSpacing = Collection.spacingWitdh
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        // 스크롤 바 없애기
        collection.showsHorizontalScrollIndicator = false
        
        
        return collection
    }()
    
    let youtube: WKWebView = {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let youtube = WKWebView(frame: .zero, configuration: config)
        youtube.backgroundColor = UIColor(red: 0.10, green: 0.11, blue: 0.10, alpha: 1.00)
        
        return youtube
    }()
    
    let wwdc: WKWebView = {
        let wwdc = WKWebView()
        
        wwdc.backgroundColor = UIColor(red: 0.10, green: 0.11, blue: 0.10, alpha: 1.00)
        return wwdc
        
    }()
    
    // MARK: - TOOLBAR
    let toolbar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.barTintColor = .black
        return toolbar
    }()
    
    lazy var goBackButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "arrowshape.backward.fill"),
            style: .plain,
            target: self, // self를 사용하려면 lazy var 지연 속성으로 사용해야 한다.
            action: #selector(didTapGoBackButton)
        )
        button.tintColor = .white
        return button
    }()
    lazy var refreshBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "arrow.clockwise.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapRefreshBarButton)
        )
        button.tintColor = .white
        return button
    }()
    lazy var goForwardBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "arrowshape.right.fill"),
            style: .plain,
            target: self,
            action: #selector(didTapReGoForwardBarButton)
        )
        button.tintColor = .white
        return button
    }()
    
    @objc func didTapGoBackButton() {
        wwdc.goBack()
    }
    @objc func didTapRefreshBarButton() {
        wwdc.reload()
    }
    @objc func didTapReGoForwardBarButton() {
        wwdc.goForward()
    }
    
    func setupToolbarItem() {
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        toolbar.items = [goBackButton, flexibleSpace, refreshBarButton, flexibleSpace, goForwardBarButton]
    }
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.10, green: 0.11, blue: 0.10, alpha: 1.00)
        self.view.addSubview(youtube)
        self.view.addSubview(year)
        self.view.addSubview(wwdc)
        self.view.addSubview(toolbar)
        autoLayout()
        maskedCorners()
        setupCollection()
        setupToolbarItem()
        getDefaultData(year: 0)
    }
    
    func setupCollection() {
        year.backgroundColor = UIColor(red: 0.10, green: 0.11, blue: 0.10, alpha: 1.00)
        year.dataSource = self
        year.delegate = self
        year.register(WWDCcell.self, forCellWithReuseIdentifier: "WWDCcell")
    }
    
    func getDefaultData(year: Int) {
        cookieStore = wwdc.configuration.websiteDataStore.httpCookieStore
        
        guard let wwdcUrl = URL(string: Years(rawValue: year)!.applePage) else { return  }
        wwdc.load(URLRequest(url: wwdcUrl))
        
        guard let youtubeUrl = URL(string: "https://www.youtube.com/embed/\(Years(rawValue: year)!.youtube)") else { return }
        youtube.load(URLRequest(url: youtubeUrl))
    }
    
    func maskedCorners() {
        // 툴바
        toolbar.clipsToBounds = true
        toolbar.layer.cornerRadius = 10
        toolbar.layer.maskedCorners = [ .layerMaxXMaxYCorner, .layerMinXMaxYCorner
            //.layerMaxXMinYCorner : 우측상단 corner
            //.layerMaxXMaxYCorner : 우측하단 corner
            //.layerMinXMaxYCorner : 좌측하단 corner
            //.layerMinXMinYCorner : 좌측상단 corner
        ]
        
        wwdc.clipsToBounds = true
        wwdc.layer.cornerRadius = 10
        
        youtube.clipsToBounds = true
        youtube.layer.cornerRadius = 10
    }
    
    func autoLayout() {
        // 컬렉션 뷰
        year.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            year.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            year.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            year.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            year.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // 플레이어
        youtube.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            youtube.heightAnchor.constraint(equalToConstant: 200),
            youtube.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            youtube.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            youtube.topAnchor.constraint(equalTo: self.year.bottomAnchor, constant: 5)
        ])
        
        // apple wwdc
        wwdc.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            wwdc.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            wwdc.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            wwdc.topAnchor.constraint(equalTo: youtube.bottomAnchor, constant: 10),
            wwdc.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            toolbar.leadingAnchor.constraint(equalTo: wwdc.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: wwdc.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: wwdc.bottomAnchor),
            toolbar.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension WWDCcontroller: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let yearList = ["2023", "2022", "2021", "2020"]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WWDCcell", for: indexPath) as! WWDCcell
        
        cell.yearText = yearList[indexPath.item]
        
        return cell
    }
    
    
}

extension WWDCcontroller: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 셀을 클릭했을 때 내가 동작시키고 싶은 행ㄷ
        getDefaultData(year: indexPath.item)
    }
}
