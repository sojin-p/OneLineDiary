//
//  Observable.swift
//  OneLineDiary
//
//  Created by 박소진 on 2023/09/13.
//

import Foundation

class Observable<T> {
    
    private var listener: ((T) -> Void)?
    
    var value: T {
        didSet {
            listener?(value)
            print("didSet \(value)")
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ completion: @escaping (T) -> Void) {
        print("\(value) 가공하는 곳")
        completion(value)
        listener = completion
    }
}
