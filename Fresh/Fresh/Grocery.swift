//
//  Grocery.swift
//  Fresh
//
//  Created by Sara on 2018-04-09.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation

struct Grocery{
    var sku = "";
    var name = "";
    var pPrice = "";
    var sPrice = "";
    var quantity = "";
    
    
    init(sku: String, name: String, pPrice: String, sPrice: String, quantity: String){
        self.sku = sku;
        self.name = name;
        self.pPrice = pPrice;
        self.sPrice = sPrice;
        self.quantity = quantity;
    }
    
}
