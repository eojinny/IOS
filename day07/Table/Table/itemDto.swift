//
//  itemDto.swift
//  Table
//
//  Created by CSMAC09 on 2023/06/30.
//

import Foundation
class ItemDto{
    var item : String?
    var imageFile : String?
    
    init(_ item: String,_ imageFile: String) {
        self.item = item
        self.imageFile = imageFile
    }
}
