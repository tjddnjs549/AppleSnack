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
    
    let categorie = "클래스"
    
    var isEditMode: Bool {
            let searchController = navigationItem.searchController
            let isActive = searchController?.isActive ?? false
            let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
            return isActive && isSearchBarHasText
        }
    
    @IBOutlet weak var snackList: UITableView!
    
    var searchResult: [MySnack] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavi()
        setupTable()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        snackList.reloadData()
    }
    // 네비게이션 설정
    func setupNavi() {
        self.title = "Snack List"
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "검색"
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchResultsUpdater = self
        
        
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
        let backButton = UIBarButtonItem(title: "뒤로", style: .done, target: self, action: #selector(backButtonTapped))

        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = button
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.largeTitleDisplayMode = .always
       
        
    }
    
    @objc func plusButtonTapped() {
        performSegue(withIdentifier: "writeVC", sender: nil)
    }
    @objc func backButtonTapped() {
        let storyboard = UIStoryboard(name: "ViewController", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "writeVC" {
            let writeVC = segue.destination as! WriteViewController
            
            writeVC.category = categorie
        }
    }
    // 테이블셀 설정
    func setupTable() {
        snackList.delegate = self
        snackList.dataSource = self
        
        
        snackList.separatorStyle = .none
    }
    
    
}

extension SnackListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isEditMode ? searchResult.count : snackManager.getSnackFromCoreData().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "snackCell", for: indexPath) as! SnackListCellTableViewCell
        
        cell.cellLabel.text = isEditMode ?
        searchResult[indexPath.row].title : snackManager.getSnackFromCoreData()[indexPath.row].title
        
        //❗️이쪽 추가 -> 색 조정
        cell.cellView.backgroundColor = UIColor(red: 0.34, green: 0.80, blue: 0.60, alpha: 1.00)
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
        vc.mySnack = isEditMode ?
        searchResult[indexPath.row] : snackManager.getSnackFromCoreData()[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "Delete") { (action, view, completionHandler) in
            self.snackManager.deleteSnack(data: self.snackManager.getSnackFromCoreData()[indexPath.row]) {
                print("삭제됏음")
                self.snackList.reloadData()
            }
              completionHandler(true)
          }
        //❗️이쪽 추가 -> 색 조정
        deleteAction.backgroundColor = UIColor(red: 0.22, green: 0.64, blue: 0.65, alpha: 1.00)
        deleteAction.image = UIImage(systemName: "trash.circle")
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return configuration
    }
}

extension SnackListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let resultText = searchController.searchBar.text else { return }
        searchResult = snackManager.getSnackFromCoreData().filter{ $0.title?.contains(resultText) ?? false || $0.text?.contains(resultText) ?? false || $0.assiURL?.contains(resultText) ?? false
            //        filteredDataSource = dataSource.filter { $0.contains(text) }
            //        self.snackList.reloadData()
        }
        snackList.reloadData()
    }
}
