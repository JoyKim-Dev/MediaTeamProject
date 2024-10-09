//
//  BaseViewModel.swift
//  MediaTeamProject
//
//  Created by 전준영 on 10/9/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol BaseViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
    var disposeBag: DisposeBag { get }
    
}
