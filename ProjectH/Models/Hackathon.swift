//
//  Hackathon.swift
//  ProjectH
//
//  Created by 송지혁 on 5/15/24.
//

import FirebaseFirestore

struct Hackathon: Identifiable, Codable, Hashable {
    @DocumentID var id: String?
    var name: String
    var description: String
}
