import UIKit
import CoreData

//MARK: - To do 관리하는 매니저 (코어데이터 관리)

final class SnackManager {
    
    static let shared = SnackManager()
    private init() {}

    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "MySnack"
    
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveToDoData(title: String?, text: String?, photo: Data?, categorie: String?, assiUrl: String?, completion: @escaping () -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                let snackData = MySnack(entity: entity, insertInto: context)

                snackData.title = title
                snackData.text = text
                snackData.textPhoto = photo
                snackData.categorie = categorie
                snackData.assiURL = assiUrl
                snackData.date = Date()

                appDelegate?.saveContext()
            }
        }
        completion()
    }
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getToDoListFromCoreData() -> [MySnack] {
        var snackList: [MySnack] = []
        if let context = context {
            let request = NSFetchRequest<MySnack>(entityName: self.modelName)
            let dateOrder = NSSortDescriptor(key: "date", ascending: false)
            request.sortDescriptors = [dateOrder]
            
            do {
                let fetchedSnack = try context.fetch(request)
                snackList = fetchedSnack
            } catch {
                print("가져오는 것 실패")
            }
        }
        return snackList
    }
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    func updateToDo(newSnackData: MySnack, completion: @escaping () -> Void) {

        guard let date = newSnackData.date else {
            return
        }
        
        if let context = context {
            let request = NSFetchRequest<MySnack>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
       
                let fetchedSnack = try context.fetch(request)

                if var targetSnack = fetchedSnack.first {
                    targetSnack = newSnackData
                    appDelegate?.saveContext()
                }
                completion()
            } catch {
                print("업데이트 실패")
            }
        }
    }
    
    // MARK: - [Delete] 코어데이터에서 데이터 삭제하기 (일치하는 데이터 찾아서 ===> 삭제)
    func deleteToDo(data: MySnack, completion: @escaping () -> Void) {
        guard let date = data.date else {
            return
        }
        
        if let context = context {
            let request = NSFetchRequest<MySnack>(entityName: self.modelName)
            request.predicate = NSPredicate(format: "date = %@", date as CVarArg)
            
            do {
                let fetchedSnack = try context.fetch(request)
                
                if let targetSnack = fetchedSnack.first {
                    context.delete(targetSnack)
                    appDelegate?.saveContext()
                }
                completion()
            } catch {
                print("지우는 것 실패")
            }
        }
    }
}
