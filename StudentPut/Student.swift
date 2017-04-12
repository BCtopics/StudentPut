//
//  Student.swift
//  StudentPut
//
//  Created by Bradley GIlmore on 4/12/17.
//  Copyright © 2017 Bradley Gilmore. All rights reserved.
//

import Foundation

struct Student {
    
    let name: String
    
}


//MARK: - JSON

extension Student {
    
    //MARK: - Keys
    static let kName = "students"
    
    init?(dictionary: [String: Any]) {
        guard let name = dictionary[Student.kName] as? String else { return nil }
        self.init(name: name)
    }
    
    var dictionaryRepresentation: [String: Any] {
        return [Student.kName: name]
    }
    
    var jsonData: Data? {
        return try? JSONSerialization.data(withJSONObject: dictionaryRepresentation, options: .prettyPrinted)
    }
}
