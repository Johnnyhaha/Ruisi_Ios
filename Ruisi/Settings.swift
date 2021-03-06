//
//  Settings.swift
//  Ruisi
//
//  Created by yang on 2017/6/24.
//  Copyright © 2017年 yang. All rights reserved.
//

import Foundation

public class Settings {
    private static let key_avater = "key_avater"
    private static let key_username = "key_username"
    private static let key_password = "key_password"
    private static let key_rember_password = "key_rember_password"
    private static let key_enable_tail = "key_enable_tail"
    private static let key_tail_content = "key_tail_content"
    private static let key_show_zhiding = "key_show_zhiding"
    private static let key_message_id_reply = "key_message_id_reply"
    private static let key_message_id_pm = "key_message_id_pm"
    private static let key_message_id_at = "key_message_id_at"
    
    static func getMessageId(type: Int) -> Int{
        switch type {
        case 0:
            return UserDefaults.standard.integer(forKey: key_message_id_reply)
        case 1:
            return UserDefaults.standard.integer(forKey: key_message_id_pm)
        case 2:
            return UserDefaults.standard.integer(forKey: key_message_id_at)
        default:
            return 0
        }
    }
    
    static func setMessageId (type: Int, value: Int) {
        switch type {
        case 0:
            return UserDefaults.standard.set(value, forKey: key_message_id_reply)
        case 1:
            return UserDefaults.standard.set(value, forKey: key_message_id_pm)
        case 2:
            return UserDefaults.standard.set(value, forKey: key_message_id_at)
        default:
            return
        }
    }
    
    
    public static var username: String? {
        get {
            return UserDefaults.standard.string(forKey: key_username)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key_username)
        }
    }
    
    public static var password: String? {
        get {
            return UserDefaults.standard.string(forKey: key_password)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key_password)
        }
    }
    
    public static var remberPassword: Bool {
        get {
            return UserDefaults.standard.bool(forKey: key_rember_password)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key_rember_password)
        }
    }
    
    // 显示置顶
    public static var showZhiding: Bool {
        get {
            return UserDefaults.standard.bool(forKey: key_show_zhiding)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key_show_zhiding)
        }
    }
    
    // 允许小尾巴
    public static var enableTail: Bool {
        get {
            return UserDefaults.standard.bool(forKey: key_enable_tail)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key_enable_tail)
        }
    }
    
    // 小尾巴内容
    public static var tailContent: String? {
        get {
            return UserDefaults.standard.string(forKey: key_tail_content)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key_tail_content)
        }
    }
    
    //size = 0 small 1 = middle 2 = large
    private static var isLoadingAvater = false
    public static func getAvater(uid: Int,size: Int = 1,callback: @escaping (Data?) -> Void) {
        var d: Data?
        if let d = UserDefaults.standard.data(forKey: "\(key_avater)_\(size)"){
            callback(d)
            return
        }
        
        DispatchQueue.global(qos:.userInitiated).async {
            do {
                try d =  Data(contentsOf: URL(string: Urls.getAvaterUrl(uid: uid,size: size))!)
                
                if d != nil {
                    setAvater(uid: uid,size: size, data: d!)
                    callback(d)
                    return
                }
            } catch {
                print(error)
            }
            
            callback(nil)
        }
    }
    
    public static func setAvater(uid: Int, size: Int = 1,data: Data) {
        DispatchQueue.global(qos: .background).async {
            UserDefaults.standard.set(data, forKey: "\(key_avater)_\(size)")
        }
    }
}
