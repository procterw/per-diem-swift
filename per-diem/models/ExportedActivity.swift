//
//  ExportedActivity.swift
//  per-diem
//
//  Created by William Leahy on 11/27/23.
//

struct ExportedActivity: Decodable, Encodable {
    let note: String
    let dateId: Int64
    let notePreview: String
    let optionType: String
    let optionIcon: String
    let optionCount: Int16
}
