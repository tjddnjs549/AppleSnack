import UIKit
import CoreData

//MARK: - To do 관리하는 매니저 (코어데이터 관리)

final class CategorieManager {
    
    static let shared = CategorieManager()
    private init() {}

    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "Categorie"
    
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveCategorieData(categorie: String?, completion: @escaping () -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                let categorieData = Categorie(entity: entity, insertInto: context)

                categorieData.categorie = categorie
                categorieData.date = Date()
                
                appDelegate?.saveContext()
            }
        }
        completion()
    }
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getCategorieData() -> [Categorie] {
        var categorieList: [Categorie] = []
        if let context = context {
            let request = NSFetchRequest<Categorie>(entityName: self.modelName)
            let dateOrder = NSSortDescriptor(key: "date", ascending: true)
            request.sortDescriptors = [dateOrder]
            
            do {
                let fetchedCategorie = try context.fetch(request)
                categorieList = fetchedCategorie
            } catch {
                print("가져오는 것 실패")
            }
        }
        return categorieList
    }
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    func updateCategorie(newCategorieData: Categorie, completion: @escaping () -> Void) {

        guard let date = newCategorieData.date else {
            return
        }
        
        if let context = context {
            let request = NSFetchRequest<Categorie>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
       
                let fetchedCategoire = try context.fetch(request)

                if var targetCategorie = fetchedCategoire.first {
                    targetCategorie = newCategorieData
                    appDelegate?.saveContext()
                }
                completion()
            } catch {
                print("업데이트 실패")
            }
        }
    }
    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
    func deleteCategorie(data: Categorie, completion: @escaping () -> Void) {
        guard let date = data.date else {
            return
        }
        
        if let context = context {
            let request = NSFetchRequest<Categorie>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                let fetchedCategorie = try context.fetch(request)
                
                if let targetCategorie = fetchedCategorie.first {
                    context.delete(targetCategorie)
                    appDelegate?.saveContext()
                }
                completion()
            } catch {
                print("지우는 것 실패")
            }
        }
    }
}
