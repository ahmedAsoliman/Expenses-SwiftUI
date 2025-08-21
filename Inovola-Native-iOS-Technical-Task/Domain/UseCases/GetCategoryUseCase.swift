//
//  GetCategoryUseCase.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 21/08/2025.
//


final class GetCategoryUseCase {
    private let repository: ExpenseRepository
    
    init(repository: ExpenseRepository) {
        self.repository = repository
    }
    
    func executeCategory() async throws -> [Category] {
        try await repository.fetchCategory()
    }
}
