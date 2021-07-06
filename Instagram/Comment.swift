//
//  Comment.swift
//  Instagram
//
//  Created by KAZUKI-OGATA on 2021/07/01.
//

import Foundation
import Firebase

class Comment: NSObject {
    var name: String?
    var comment: String?
    
    init(commentDic: [String : Any]) {
        self.name = commentDic["name"] as? String
        self.comment = commentDic["comment"] as? String
    }
}
