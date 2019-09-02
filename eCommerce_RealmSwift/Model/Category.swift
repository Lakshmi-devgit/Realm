//
//  Category.swift
//  eCommerce_RealmSwift
//
//  Created by Lakshmi on 02/09/19.
//  Copyright © 2019 Personal. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    @objc dynamic var desc = ""
    @objc dynamic var amount = ""
}

