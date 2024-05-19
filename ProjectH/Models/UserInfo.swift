//
//  UserInfo.swift
//  ProjectH
//
//  Created by 송지혁 on 5/18/24.
//

import FirebaseFirestore

struct UserInfo: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    let uid: String
    let email: String
    let nickname: String
    var bookmarks: Set<String>
}
