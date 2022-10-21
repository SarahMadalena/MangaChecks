//
//  API.swift
//  MangaChecks
//
//  Created by Sarah Madalena on 21/10/22.
//

import Foundation

struct API {
    //método que chama a API
    static func makeRequest(completion: @escaping ([MangasData]) -> ()) { // funcao de tipo
        let url = URL(string: "https://api.jikan.moe/v4/manga")!
        
        //tratando o retorno da chamada para fazer o que quiser
        //a task controla o cíclo de vida da chamada
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            print("response: \(String(describing: response))")
            print("error: \(String(describing: error))")
            
            //convertendo data para string
            guard let responseData = data else { return }
            
            do {
                //passando o tipo de objeto que quer que ele converta
                let result = try JSONDecoder().decode(Result.self, from: responseData)
                completion(result.data)
            } catch let error {
                print("error: \(error)")
            }
        }
        task.resume()
    }
}
