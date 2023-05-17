//
//  Memo.swift
//  DatabaseRealm
//
//  Created by 杉井位次 on 2023/05/17.
//

import Foundation
import RealmSwift

//メモクラスを定義
class Memo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
}
