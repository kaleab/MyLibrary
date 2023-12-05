//
//  File.swift
//  
//
//  Created by Kal Y on 12/5/23.
//

import Foundation
import Combine
import Alamofire

@available(macOS 10.15, *)
public class IPAddressViewModel: ObservableObject {
    @Published public var ipAddressData: IPAddressData?
    @Published public var errorMessage: String? = nil
    @Published public var isLoading = false

    var cancellables = Set<AnyCancellable>()
    
    public init() { }
    
    public func fetchIPAddressData() {
        isLoading = true
        let url = "https://ipapi.co/json/"
        
        AF.request(url)
            .validate()
            .publishDecodable(type: IPAddressData.self)
            .delay(for: 1.0, scheduler: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = "Error: The operation couldn’t be completed. (error: invalidURL  \(url))"
                }
            } receiveValue: { dataResponse in
                self.ipAddressData = dataResponse.value
                if dataResponse.value == nil {
                    self.errorMessage = "Error: The operation couldn’t be completed. (error: invalidURL \(url))"
                }else {
                    self.errorMessage = nil
                    self.isLoading = false
                }
                
            }
            .store(in: &cancellables)
    }
}
