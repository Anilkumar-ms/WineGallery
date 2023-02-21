//
//  AppClient.swift
//  WineGallery
//
//  Created by Anilkumar on 21/02/23.
//

import Foundation

import Combine

///I am using a struct based approach rather than Protocol to networking and dependency injection in this class.
///
///Using protocol will create a lot of boilerplate code. And it will be kind of tedious.  And in this approach, both the mocking and even conversion to the live sources, dummy data, error case.is very easy. And also we have these fakers and the fake success methods, Help us in architecting, the views inside the previous provider.
///The live data, fake success, fake error can be tested without switching off the Internet and switching on the Internet.
///
///AppClient is data feeder layer to calling class
struct AppClient {
    var products: () -> AnyPublisher<[Product], Error>
}

extension AppClient {
    private struct Products: Decodable { let products: [Product] }
    ///live - This constant indicate live [Products] data will be to retured to calling class
    ///In Live data, we actually do network request, get the lalest product information data from server and returns product information
    static let live = Self(
        products: {
            guard let url = URL(string: "https://run.mocky.io/v3/2f06b453-8375-43cf-861a-06e95a951328") else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            return URLSession.shared
                .dataTaskPublisher(for: url)
                .retry(1)
                .tryMap ({ (data, response) -> Data in
                    if
                        let response = response as? HTTPURLResponse,
                        response.statusCode != 200 {
                        throw URLError(.badServerResponse)
                    }
                    return data
                })
                .receive(on: DispatchQueue.main)
                .decode(type: Products.self, decoder: JSONDecoder())
                .map(\.products)
                .eraseToAnyPublisher()
        }
    )
    
    ///fakeError - This constant indicate there is falure in network call.
    ///This is mainly used for Unit testing to mock failure case
    static let fakeError = Self(
        products: {
            Fail(error: URLError(.cannotFindHost))
                .eraseToAnyPublisher()
        }
    )
    
    ///fakeSuccess - This constant will return fakeSuccess with Dummy data
    ///This is mainly used for Unit testing to mock Success case without doing network call
    static let fakeSuccess = Self(
        products: {
            Just([.dummy, .dummy, .dummy] as [Product])
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    )
}
