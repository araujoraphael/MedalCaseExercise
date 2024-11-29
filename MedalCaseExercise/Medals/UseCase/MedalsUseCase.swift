//
//  MedalsUseCase.swift
//  MedalCaseExercise
//
//  Created by Raphael Araújo on 2024-11-26.
//

import Foundation

enum MedalsUseCaseRequestError: Error {
    case invalidResponse
    case invalidJSON
}
protocol MedalsUseCaseProtocol {
    func fetchMedals(completion: @escaping (Result<MedalsCaseModel, MedalsUseCaseRequestError>) -> Void)
}

class MedalsUseCase: MedalsUseCaseProtocol {
    func fetchMedals(completion: @escaping (Result<MedalsCaseModel, MedalsUseCaseRequestError>) -> Void) {
        
        guard let jsonURL = Bundle.main.url(forResource: "medals", withExtension: "json") else {
            completion(.failure(.invalidResponse))
            return
        }
        
        do {
            let data = try Data(contentsOf: jsonURL)
            
            let medalsCase = try JSONDecoder().decode(MedalsCaseModel.self, from: data)
            
            completion(.success(medalsCase))
        } catch(let error) {
            debugPrint(">>> error parsing MedalsCaseModel: \(error.localizedDescription) ")
            completion(.failure(.invalidJSON))
        }
    }
}
