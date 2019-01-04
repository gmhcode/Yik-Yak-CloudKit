//
//  YakController.swift
//  YikYak
//
//  Created by Greg Hughes on 1/3/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import Foundation
import CloudKit

class YakController{
    
    
    static let shared = YakController()
    
    private init() {}
    
    var yaks : [Yak] = []
    
    //CRUD
    
    func birthYoungYak(text: String, title: String, completion:  ((Yak?) -> ())?) {
        
        let youngYak = Yak(title: title, text: text)
        self.yaks.append(youngYak)
        
        
        
        CKContainer.default().publicCloudDatabase.save(youngYak.asCKRecord) { (record, error) in
            if let error = error {
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
                completion?(nil)
                return
            }
            
            guard let record = record else {completion?(nil) ; return}
            
            let yak = Yak(ckRecord: record)
            completion?(yak)
            
            
        }
    }
    
    
    
    func herdAllYaks(completion: @escaping ([Yak]) -> Void ) {
        
       
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Keys.yakRecordType, predicate: predicate)
        
        CKContainer.default().publicCloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
                completion([])
                return
            }
            
            guard let records = records else {completion([]) ; return}
            
            let mappedYaks = records.compactMap { Yak(ckRecord: $0 )}
            self.yaks = mappedYaks
            completion(mappedYaks)
        }
    }
    
    func delete(yak: Yak, completion: @escaping (Bool) -> Void){
        
        CKContainer.default().publicCloudDatabase.delete(withRecordID: yak.recordID) { (_, error) in
            if let error = error {
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription)")
                completion(false)
                return
            }
           completion(true)
        }
    }
    
    
    
    
    func updateYak(yak: Yak, upVotes: Int, downVotes: Int, completion: @escaping (Bool)->Void){
        
        yak.upVote = upVotes
        yak.downVote = downVotes
        
        
    }
}
