//
//  Sample.swift
//  Week9
//
//  Created by SC on 2022/09/01.
//

import Foundation

class User<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("value changed: \(oldValue) -> \(value)")  // oldValue: 기본 파라미터
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ completionHandler: @escaping (T) -> Void) {
//        completionHandler(value)
        listener = completionHandler
    }
    
    
    
    
    
//    private var listener: ((String) -> Void)?
//
//    var value: String {
//        didSet {
//            print("value changed: \(oldValue) -> \(value)")  // oldValue: 기본 파라미터
//            listener?(value)
//        }
//    }
//
//    init(_ value: String) {
//        self.value = value
//    }
//
//    func bind(_ completionHandler: @escaping (String) -> Void) {
////        completionHandler(value)
//        listener = completionHandler
//    }
  
    
    
    
    
    
//    //    private var listener: () -> Void = { print("👂🏻 name changed") }
//    //    private var listener: ㅌ() -> Void = { print("👂🏻 name changed: \(oldValue) -> \(name)") }  // oldValue가 없기 때문에 컴파일 에러
//    //    private var listener: (String, String) -> Void = { oldName, newName in
//    //        print("👂🏻 name changed: \(oldName) -> \(newName)")
//    //    }  // oldValue와 name을 매개변수로 받기
//        private var listener: () -> Void = { print("👂🏻 name changed function") }
    
    
//    var name: String {
//        didSet {
//            print("name changed: \(oldValue) -> \(name)")  // oldValue: 기본 파라미터
////            listener()
////            listener(oldValue, name)
//            listener()
//        }
//    }
//
//    init(name: String) {
//        self.name = name
//    }
    
//    func nameChanged(completionHandler: @escaping () -> Void) {
//        completionHandler()
//        listener = completionHandler
//    }
}
