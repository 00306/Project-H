//
//  User+.swift
//  ProjectH
//
//  Created by 송지혁 on 5/21/24.
//

import Firebase

extension User {
    func toUserInfo() -> UserInfo {
        return UserInfo(uid: self.uid, email: self.email ?? "", nickname: self.displayName ?? "", bookmarks: [])
    }
}
