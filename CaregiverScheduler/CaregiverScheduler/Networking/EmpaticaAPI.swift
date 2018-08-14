//
//  EmpaticaAPI.swift
//  CaregiverScheduler
//
//  Created by Jean Raphael on 13/08/2018.
//  Copyright © 2018 Jean Raphael. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import Moya

class EmpaticaAPI: EmpaticaAPIProtocol {
    private let provider = MoyaProvider<EmpaticaService>(plugins: [NetworkLoggerPlugin()])
    
    private let bag = DisposeBag()
    
    // MARK: - EmpaticaAPIProtocol
    
    func fetchCaregivers(_ seed: String, resuts: Int) -> Observable<[Caregiver]> {
        return Observable.create { observer in
            self.provider
                .rx
                .request(.users(seed: seed, results: resuts))
                .subscribe(onSuccess: { response in
                    do {
                        let mangaDecoded = try response.map(Results.self)
                        
                        observer.onNext(mangaDecoded.results)
                    } catch {
                        observer.onError(error)
                    }
                    
                    observer.on(.completed)
                }, onError: { error in
                    observer.on(.completed)
                })
                .disposed(by: self.bag)
            
            return Disposables.create()
        }
    }
}

