//
//  InputCommentViewController.swift
//  Instagram
//
//  Created by KAZUKI-OGATA on 2021/06/28.
//

import UIKit
import Firebase
import SVProgressHUD

class InputCommentViewController: UIViewController {
    @IBOutlet weak var inputCommentView: UITextView!
    
    var postData: PostData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        inputCommentView.layer.borderColor = UIColor.black.cgColor
        inputCommentView.layer.borderWidth = 1.0
    }
    
    @IBAction func handlePostButton(_ sender: Any) {
        SVProgressHUD.show()
        let inputComment = inputCommentView.text
        if inputComment == "" {
            SVProgressHUD.showError(withStatus: "コメントの入力がありません")
            return
        }
        
        let user = Auth.auth().currentUser
        if user == nil {
            SVProgressHUD.showError(withStatus: "ログインされていません")
            return
        }

        // 更新データを作成する
        var updateValue: FieldValue
        
        // コメントデータを追記
        updateValue = FieldValue.arrayUnion([
            [
                // name, commentが一致するコメントの場合に重複で無効化されてしまう
                "name" : user!.displayName!,
                "comment" : inputComment!
            ] as [String: Any]])
        
        // 更新データを書き込む
        let postRef = Firestore.firestore().collection(Const.PostPath).document(self.postData.id)
        postRef.updateData(["comments": updateValue])
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
