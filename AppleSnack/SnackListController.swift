//
//  SnackListController.swift
//  AppleSnack
//
//  Created by Macbook on 2023/08/19.
//

import UIKit

class SnackListController: UIViewController {
    
    //    var snackList: [MySnack] = []
    let snackManager = SnackManager.shared
    var mySnack: [MySnack] = []
    var searchResult: [MySnack] = []
    var listCategorie = "카테고리"
    
    var isEditMode: Bool {
            let searchController = navigationItem.searchController
            let isActive = searchController?.isActive ?? false
            let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
            return isActive && isSearchBarHasText
        }
    
    @IBOutlet weak var snackList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setupNavi()
        setupTable()
        loadSnack()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSnack()
        snackList.reloadData()
    }
    // 네비게이션 설정
    func setupNavi() {
        self.title = "\(listCategorie) List"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        // 검색상태에서 상태창 숨김기능
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        button.tintColor = .black
        
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = button
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always
        
    }
    
    @objc func plusButtonTapped() {
        performSegue(withIdentifier: "writeVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "writeVC" {
            let writeVC = segue.destination as! WriteViewController
            
            writeVC.category = listCategorie
        }
    }
    // 테이블셀 설정
    func setupTable() {
        snackList.delegate = self
        snackList.dataSource = self
        snackList.separatorStyle = .none
    }
    
    func loadSnack() {
        mySnack = snackManager.getSnackFromCoreData().filter({ $0.categorie == listCategorie})
    }
}

extension SnackListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEditMode ? searchResult.count : mySnack.filter({ $0.categorie == listCategorie}).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "snackCell", for: indexPath) as! SnackListCellTableViewCell
        
        cell.cellLabel.text = isEditMode ?
        searchResult[indexPath.row].title : mySnack.filter({ $0.categorie == listCategorie})[indexPath.row].title
        
        return cell
    }
    
    
}

extension SnackListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DetailViewStoryboard", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewStoryboard") as! DetailViewController
        vc.snackNumber = indexPath.row
        
        // 검색중에도 배열의 순서가 바꿈으로 isEditMode(참, 거짓)으로 배열 재배치
        vc.mySnack = isEditMode ?
        searchResult[indexPath.row] : mySnack.filter({ $0.categorie == listCategorie})[indexPath.row]
        vc.category = listCategorie
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let snack = isEditMode ?
        searchResult[indexPath.row] : mySnack.filter({ $0.categorie == listCategorie})[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            self.snackManager.deleteSnack(data: snack) {
                print("삭제됏음")
                self.loadSnack()
                
                // 서치컨트롤러에서도 삭제해주면 테이블셀의 색이 남지 않고 업데이트 된다.
                if self.isEditMode == true {
                    self.searchResult.remove(at: indexPath.row)
                }

                self.snackList.reloadData()
            }
              completionHandler(true)
          }
        deleteAction.backgroundColor = .gray
        deleteAction.image = UIImage(systemName: "trash.circle")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
}

extension SnackListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultText = searchController.searchBar.text else { return }
        searchResult = mySnack.filter({ $0.categorie == listCategorie}).filter{ $0.title?.contains(resultText) ?? false || $0.text?.contains(resultText) ?? false || $0.assiURL?.contains(resultText) ?? false
            //        filteredDataSource = dataSource.filter { $0.contains(text) }
            //        self.snackList.reloadData()
        }
        snackList.reloadData()
    }
}

extension SnackListController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
    }
}
