//
//  MedalModel.swift
//  MedalCaseExercise
//
//  Created by Raphael Araújo on 2024-11-26.
//

enum AchievementType: String, Codable {
    case time
    case longTime
    case distance
    case unachieved
}
struct Achievement: Codable {
    let value: String
    let type: AchievementType
}

enum MedalType: String, Codable {
    case virtualRaces
    case personalRecords
}

struct Medal: Codable {
    let title: String
    let achievement: Achievement
    let icon: String
    let type: MedalType
}

struct MedalsCaseModel: Codable {
    let medalTypes: [MedalType]
    let medals: [Medal]
}
