//
//  Store.swift
//  Fresh
//
//  Created by Sara on 2018-04-12.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation

struct Store{
    var storeid = "";
    var street = "";
    var city = "";
    var province = "";
    var postalcode = "";
    var phone = "";
    
    init(storeid: String, street: String, city: String, province: String, postal: String, phone: String){
        self.storeid = storeid;
        self.street = street;
        self.city = city;
        self.province = province;
        self.postalcode = postal;
        self.phone = phone
    }
}
