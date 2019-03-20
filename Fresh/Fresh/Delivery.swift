//
//  Delivery.swift
//  Fresh
//
//  Created by Sara on 2018-04-12.
//  Copyright © 2018 Sara. All rights reserved.
//

import Foundation

struct Delivery{
    var deliveryid = "";
    var planneddeliverydate = "";
    var actualdeliverydate = "";
    var delivered = "";
    var employeetodeliver = "";
    
    init(deliveryid: String, planneddeliverydate: String, actualdeliverydate: String, delivered: String, employeetodeliver: String){
        self.deliveryid = deliveryid;
        self.planneddeliverydate = planneddeliverydate;
        self.actualdeliverydate = actualdeliverydate;
        self.delivered = delivered;
        self.employeetodeliver = employeetodeliver;
        print(self);
    }
    
}
