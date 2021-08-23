//
//  DayOfMonth.swift
//  Marketeiros
//
//  Created by Gonzalo Ivan Santos Portales on 21/07/21.
//

import Foundation

struct MDPDayOfMonth {
    // used to keep track of this DayOfMonth's position in its collection
    var index = 0
    
    // a day of zero (0) means that this day will appear blank and is unusable. otherwise this
    // is the actual calendar day of the month
    var day = 0
    
    // the real Date being represented by this struct. this value is created to make comparisons
    // faster.
    var date: Date? = nil
    
    // set to true if this DayOfMonth may be selected by the user
    var isSelected = false
    
    // set to true only if this DayOfMonth represents the live, current, day
    var isToday = false
}
