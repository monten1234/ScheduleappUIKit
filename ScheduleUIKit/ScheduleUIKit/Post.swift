//
//  Model.swift
//  ScheduleUIKit
//
//  Created by adachitakehiro2 on 2023/02/23.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

// Post Model...
struct ScheduleInfo: Identifiable,Codable{
    @DocumentID var id: String?
    var date: Date
    var title: String?
    var memo: String?    
    enum CodingKeys: String,CodingKey{
        case id
        case date
        case title
        case memo
    }
}

struct UserData: Identifiable, Codable {
    @DocumentID var id: String?
    var mail: String?
    var name: String?
}
