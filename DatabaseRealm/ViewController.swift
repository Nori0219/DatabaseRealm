//
//  ViewController.swift
//  DatabaseRealm
//
//  Created by 杉井位次 on 2023/05/17.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextField!
    
    //Realmの変数を宣言
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Memo型の定数memoを初期化　readメソッドで取得したデータをmemoに保存する
        let memo: Memo? = read()
        
        //memoがnilになっているときエラーになるためOptionalChangingを使ってエラー回避している(?)
        titleTextField.text = memo?.title
        contentTextField.text = memo?.content
    }
    
    //Realmにアクセスしてメモの情報を読み出す
    func read() -> Memo? {
        //Memoから最初のデータを取り出す
        return realm.objects(Memo.self).first
    }
    
    @IBAction func save() {
        //テキストフィールドの文字列を取得し、定数に代入
        let title: String = titleTextField.text!
        let content: String = contentTextField.text!
        
        //既に保存されているメモを取得
        let memo: Memo? = read()
        
        if memo != nil { //メモにデータが保存されている場合は、データを更新する
            try! realm.write {//保存するときはこのブロックの中に書く
                memo!.title = title
                memo!.content = content
            }
        } else { //メモを新規作成してDBに保存
            let newMemo = Memo()//インスタンスを宣言し代入
            newMemo.title = title
            newMemo.content = content
            
            try! realm.write{
                realm.add(newMemo)
            }
        }
        
        //alertを作成する
        let alert = UIAlertController(
            title: "成功",
            message: "保存しました",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        ))
        present(alert, animated: true, completion: nil)
        
    }
}

