//
//  BaseAPI.swift
//  SurfMate_iOS
//
//  Created by Jun on 2023/01/18.
//

import Foundation
import Moya
import RxSwift

//네트워크 호출 상속용
class BaseRepository<API: TargetType> {
    let disposeBag = DisposeBag()
    private let provider = MoyaProvider<API>()
    lazy var rx = provider.rx
}
