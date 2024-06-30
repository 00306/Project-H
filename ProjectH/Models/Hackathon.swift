//
//  Hackathon.swift
//  ProjectH
//
//  Created by 송지혁 on 5/15/24.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftData

@Model
class Hackathon: Identifiable, Codable, Hashable {
    var id: String?
    let name: String
    let content: String
    var hits: Int
    let imageUrl: String
    let startDate: Date
    let endDate: Date
    var duration: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: startDate)
        let end = calendar.startOfDay(for: endDate)
        let components = calendar.dateComponents([.day], from: start, to: end)
        
        return components.day ?? 0
    }
    
    enum CodingKeys: CodingKey {
        case id, name, content, hits, imageUrl, startDate, endDate
    }
    
    init(id: String? = nil, name: String, content: String, hits: Int, imageUrl: String, startDate: Date, endDate: Date) {
        self.id = id
        self.name = name
        self.content = content
        self.hits = hits
        self.imageUrl = imageUrl
        self.startDate = startDate
        self.endDate = endDate
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.content = try container.decode(String.self, forKey: .content)
        self.hits = try container.decode(Int.self, forKey: .hits)
        self.imageUrl = try container.decode(String.self, forKey: .imageUrl)
        self.startDate = try container.decode(Date.self, forKey: .startDate)
        self.endDate = try container.decode(Date.self, forKey: .endDate)
        
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(content, forKey: .content)
        try container.encode(hits, forKey: .hits)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(startDate, forKey: .startDate)
        try container.encode(endDate, forKey: .endDate)
        
        
    }
    public static func ==(lhs: Hackathon, rhs: Hackathon) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(ObjectIdentifier(self))
    }
}
