//
//  RealmRepository.swift
//  MediaTeamProject
//
//  Created by Joy Kim on 10/9/24.
//

import Foundation
import RealmSwift

final class RealmRepository {
    
    static let shared = RealmRepository()
    private init() {}
    
    var realm: Realm {
        return try! Realm()
    }
    
    var fileURL: URL? {
        return realm.configuration.fileURL
    }
    
    // MARK: - Add
    
    func addItem(_ item: LikedMedia) {
        print(#function)
        do {
                try realm.write {
                        realm.add(item)
                }
                print("Realm 추가 완료")
            } catch {
                print("Realm 추가 실패: \(error.localizedDescription)")
            }
        }
    
    // MARK: - Fetch
    
    func fetchitem(_ id: Int) -> LikedMedia? {
        return realm.object(ofType: LikedMedia.self, forPrimaryKey: id)
    }
    
    func fetchAll() -> Results<LikedMedia> {
        return realm.objects(LikedMedia.self).sorted(byKeyPath: "date", ascending: true)
    }
        
    // MARK: - Delete
    
    func deleteItem(_ id: Int) {
       
            do {
                guard let item = fetchitem(id) else {
                    print("Realm에 없는 내역")
                    return
                }
                
                try realm.write {
                    realm.delete(item)
                    print("Realm에서 삭제 성공")
                }
            } catch {
                print("Realm에서 삭제 실패: \(error.localizedDescription)")
            }
        }
    
    
    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Realm 모든 내역 삭제 성공")
        }
    }
}
