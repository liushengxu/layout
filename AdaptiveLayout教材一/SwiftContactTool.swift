//
//  SwiftContactTool.swift
//  AdaptiveLayout教材一
//
//  Created by notebook37 on 15/1/13.
//  Copyright (c) 2015年 51auto. All rights reserved.
//

import Foundation
import AddressBook
import AddressBookUI

func getSysContacts() -> [[String:String]] {
    var error:Unmanaged<CFError>?
    var addressBook: ABAddressBookRef? = ABAddressBookCreateWithOptions(nil, &error).takeRetainedValue()
    
    let sysAddressBookStatus = ABAddressBookGetAuthorizationStatus()
    
    if sysAddressBookStatus == .Denied || sysAddressBookStatus == .NotDetermined {
        // Need to ask for authorization
        var authorizedSingal:dispatch_semaphore_t = dispatch_semaphore_create(0)
        var askAuthorization:ABAddressBookRequestAccessCompletionHandler = { success, error in
            if success {
                ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray
                dispatch_semaphore_signal(authorizedSingal)
            }
        }
        ABAddressBookRequestAccessWithCompletion(addressBook, askAuthorization)
        dispatch_semaphore_wait(authorizedSingal, DISPATCH_TIME_FOREVER)
    }
    
    return analyzeSysContacts( ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as NSArray )
}

func analyzeSysContacts(sysContacts:NSArray) -> [[String:String]] {
    var allContacts:Array = [[String:String]]()
    for contact in sysContacts {
        var currentContact:Dictionary = [String:String]()
        // 姓
        currentContact["FirstName"] = ABRecordCopyValue(contact, kABPersonFirstNameProperty)?.takeRetainedValue() as String? ?? ""
        // 名
        currentContact["LastName"] = ABRecordCopyValue(contact, kABPersonLastNameProperty)?.takeRetainedValue() as String? ?? ""
        // 昵称
        currentContact["Nikename"] = ABRecordCopyValue(contact, kABPersonNicknameProperty)?.takeRetainedValue() as String? ?? ""
        // 公司（组织）
        currentContact["Organization"] = ABRecordCopyValue(contact, kABPersonOrganizationProperty)?.takeRetainedValue() as String? ?? ""
        // 职位
        currentContact["JobTitle"] = ABRecordCopyValue(contact, kABPersonJobTitleProperty)?.takeRetainedValue() as String? ?? ""
        // 部门
        currentContact["Department"] = ABRecordCopyValue(contact, kABPersonDepartmentProperty)?.takeRetainedValue() as String? ?? ""
        //备注
        currentContact["Note"] = ABRecordCopyValue(contact, kABPersonNoteProperty)?.takeRetainedValue() as String? ?? ""
        allContacts.append(currentContact)
    }
    return allContacts
}