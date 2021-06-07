//
//  ViewControllerInteractor.swift
//  ios-network-layer-demo
//
//  Created by billy.cychan on 7/6/2021.
//

import Foundation
import PromiseKit
import ProgressHUD

protocol ViewControllerInteractorProtocol: class {
    func getRouteList() -> Promise<[Route]>
}

public class ViewControllerInteractor: ViewControllerInteractorProtocol {
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func getRouteList() -> Promise<[Route]> {
        return  Promise<[Route]> { seal in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.networkService.getRouteList()
                    .done { response in
                        seal.fulfill(response.data)
                    }.catch { error in
                        seal.reject(error)
                    }.finally {
                        //
                    }
            }
            
        }
    }
}
