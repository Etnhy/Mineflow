//
//  SettingsStorageError.swift
//  Mineflow
//
//  Created by evhn on 10.11.2025.
//


enum SettingsStorageError: Error {
    case encodingFailed(Error)
    case decodingFailed(Error)
}