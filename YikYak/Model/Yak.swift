//
//  Yak.swift
//  YikYak
//
//  Created by Greg Hughes on 1/3/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import Foundation
import CloudKit
class Yak {
    
    
    
    
    
    var title : String
    var text : String
    var upVote : Int
    var downVote : Int
    let timestamp : Date
    
    let recordID : CKRecord.ID
    
    
    init(title : String, text: String, upVote: Int = 0, downVote: Int = 0, recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString), timestamp: Date = Date()){
        
        
        self.title = title
        self.text = text
        self.upVote = upVote
        self.downVote = downVote
        self.timestamp = timestamp
        self.recordID = recordID
        
    }
    
    
    convenience init?(ckRecord: CKRecord) {
        
        
        guard let text = ckRecord[Keys.text] as? String,
            let title = ckRecord[Keys.title] as? String,
            let upVote = ckRecord[Keys.upVote] as? Int,
            let downvote = ckRecord[Keys.downVote] as? Int,
            let timestamp = ckRecord[Keys.timestamp] as? Date
            else { return nil}
        
        self.init(title: title, text: text, upVote: upVote, downVote: downvote, recordID: ckRecord.recordID, timestamp: timestamp)
    }
    
    
    
    var asCKRecord: CKRecord {
        
        let newRecord = CKRecord(recordType: Keys.yakRecordType, recordID: self.recordID)
        
        newRecord.setValue(self.title, forKey: Keys.title)
        newRecord.setValue(self.text, forKey: Keys.text)
        newRecord.setValue(self.upVote, forKey: Keys.upVote)
        newRecord.setValue(self.downVote, forKey: Keys.downVote)
        newRecord.setValue(self.timestamp, forKey: Keys.timestamp)
        
        return newRecord
    } 
}

//extension CKRecord {
//
//    convenience init(yak: Yak){
//
//        self.init(recordType: Keys.yakRecordType, recordID: yak.recordID)
//    }
//
//
//}


struct Keys {
    
    static let yakRecordType = "Yak"
    static let title = "title"
    static let text = "text"
    static let upVote = "upVote"
    static let downVote = "downVote"
    static let timestamp = "timestamp"
    
    
}

