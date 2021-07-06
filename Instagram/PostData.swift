//
//  PostData.swift
//  Instagram
//
//  Created by KAZUKI-OGATA on 2021/06/25.
//

import Foundation
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    var likes: [String] = []
    var isLiked: Bool = false
    var comments: [Comment] = []

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID
        
        let postDic = document.data()
        self.name = postDic["name"] as? String
        self.caption = postDic["caption"] as? String

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myId = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myId) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
        if let comments = postDic["comments"] as? [[String : Any]] {
            self.comments = comments.map(Comment.init)
        }
    }
}
