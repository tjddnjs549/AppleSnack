import UIKit
import CoreData

//MARK: - To do 관리하는 매니저 (코어데이터 관리) //

final class ProfileManager {
    
    static let shared = ProfileManager()
    private init() {}
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    lazy var context = appDelegate?.persistentContainer.viewContext
    
    let modelName: String = "MyProfile"
    
    
    // MARK: - [Create] 코어데이터에 데이터 생성하기
    func saveToDoData(name: String?, photo: Data?, git: String?, blog: String?, completion: @escaping () -> Void) {
        if let context = context {
            if let entity = NSEntityDescription.entity(forEntityName: self.modelName, in: context) {
                
                let profile = MyProfile(entity: entity, insertInto: context)
                
                profile.name = name
                profile.photo = photo
                profile.github = git
                profile.blog = blog
                
                appDelegate?.saveContext()
            }
        }
        completion()
    }
    
    // MARK: - [Read] 코어데이터에 저장된 데이터 모두 읽어오기
    func getToDoListFromCoreData() -> [MyProfile] {
        var profile: [MyProfile] = []
        if let context = context {
            let request = NSFetchRequest<MyProfile>(entityName: self.modelName)
            
            do {
                let fetchedProfile = try context.fetch(request)
                profile = fetchedProfile
            } catch {
                print("가져오는 것 실패")
            }
        }
        return profile
    }
    
    // MARK: - [Update] 코어데이터에서 데이터 수정하기 (일치하는 데이터 찾아서 ===> 수정)
    func updateToDo(newToDoData: MyProfile, completion: @escaping () -> Void) {
        
        if let context = context {
            let request = NSFetchRequest<MyProfile>(entityName: self.modelName)
            
            do {
                if var fetchedProfile = try context.fetch(request).first {
                    fetchedProfile = newToDoData
                    appDelegate?.saveContext()
                }
                completion()
            } catch {
                print("업데이트 실패")
            }
        }
    }
}
