//
//  AddEventViewModel.swift
//  EventsApp
//
//  Created by seunghwan.yoo on 2020/05/22.
//  Copyright © 2020 seunghwan.yoo. All rights reserved.
//

import UIKit

final class AddEventViewModel {
    
    let title = "Add"
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)        
    }
    
    private(set) var cells: [AddEventViewModel.Cell] = []
    weak var coordinator: AddEventCoordinator? // weakする理由 -> closeする時にすぐdeallocするため
    
    private var nameCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private var backgroundImageCellViewModel: TitleSubtitleCellViewModel?
    private let cellBuilder: EventsCellBuilder
    private let eventService: EventServiceProtocol
    
    lazy var dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyy"
        return dateFormatter
    }()
        
    init(cellBuilder: EventsCellBuilder, eventService: EventServiceProtocol = EventService()) {
        self.cellBuilder = cellBuilder
        self.eventService = eventService
    }
    
    func viewDidLoad() {
        setupCells()
        onUpdate()
    }
    
    func viewDidDisappear() {
        coordinator?.didFinish()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func tappedDone() {
        guard let name = nameCellViewModel?.subtitle,
            let dateString = dateCellViewModel?.subtitle,
            let date = dateFormatter.date(from: dateString),
            let image = backgroundImageCellViewModel?.image
            else { return }
        
        eventService.perform(.add, data: EventService.EventInputData(name: name, date: date, image: image))
        coordinator?.didFinishSaveEvent()
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            guard titleSubtitleCellViewModel.type == .image else {
                return
            }
            coordinator?.showImagePicker { image in
                titleSubtitleCellViewModel.update(image)
                
            }
        }
    }
}

private extension AddEventViewModel {
    func setupCells() {
        nameCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) { [weak self] in
            self?.onUpdate()
        }
        backgroundImageCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.image) { [weak self] in
            self?.onUpdate()
        }
        
        guard  let nameCellViewModel = nameCellViewModel, let dateCellViewModel = dateCellViewModel, let backgroundImageCellViewModel = backgroundImageCellViewModel else { return }
        
        cells = [
            .titleSubtitle(nameCellViewModel),
            .titleSubtitle(dateCellViewModel),
            .titleSubtitle(backgroundImageCellViewModel)
        ]
    }
}

