//
//  DashboardViewModel+Observers.swift
//  Inovola-Native-iOS-Technical-Task
//
//  Created by Ahmed Soliman on 19/08/2025.
//


import Foundation
import CoreData
import Combine

extension DashboardViewModel {
    func observeContextChanges() {
        NotificationCenter.default.publisher(
            for: .NSManagedObjectContextObjectsDidChange,
            object: context
        )
        .debounce(for: .milliseconds(80), scheduler: RunLoop.main)
        .sink { [weak self] _ in
            guard let self else { return }
            Task { await self.refreshAll() }
        }
        .store(in: &cancellables)

        NotificationCenter.default.publisher(
            for: .NSManagedObjectContextDidSave,
            object: nil
        )
        .receive(on: RunLoop.main)
        .sink { [weak self] note in
            guard let self = self,
                  let savingContext = note.object as? NSManagedObjectContext,
                  savingContext != self.context else { return }

            self.context.perform {
                self.context.mergeChanges(fromContextDidSave: note)
                Task { await self.refreshAll() }
            }
        }
        .store(in: &cancellables)
    }
}
