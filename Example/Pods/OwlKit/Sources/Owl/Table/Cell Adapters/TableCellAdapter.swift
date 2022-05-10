//
//  Owl
//  A declarative type-safe framework for building fast and flexible list with Tables & Collections
//
//  Created by Daniele Margutti
//   - Web: https://www.danielemargutti.com
//   - Twitter: https://twitter.com/danielemargutti
//   - Mail: hello@danielemargutti.com
//
//  Copyright © 2019 Daniele Margutti. Licensed under Apache 2.0 License.
//

import UIKit

open class TableCellAdapter<Model: ElementRepresentable, Cell: ReusableViewProtocol>: TableCellAdapterProtocol {

    // MARK: - Public Properties -

    /// This is the model type used to dequeue the model. You should not alter it.
    public var modelType: Any.Type = Model.self
    
    /// This is the cell type used to dequeue the model. You should not alter it.
    public var modelViewType: Any.Type = Cell.self
    
    /// This is the reusable identifier to dequeue cell. By default is set to the same
    /// name of the class used as `Cell` but you can override it before using the adapter itself.
    public var reusableViewIdentifier: String
    
    /// This is the source used to dequeue the cell itself. By default is set to `.fromStoryboard`
    /// and it means the cell UI is searched inside the the director's table.
    /// You can however set it before the first dequeue is made to load it as class or from an external xib.
    public var reusableViewLoadSource: ReusableViewLoadSource

	/// Events you can observe from the adapter.
	public let events = EventsSubscriber()

	// MARK: - Initialization -
	
	public init(_ configuration: ((TableCellAdapter) -> ())? = nil) {
        self.reusableViewIdentifier = String(describing: Cell.self)
        self.reusableViewLoadSource = .fromStoryboard
		configuration?(self)
	}

	// MARK: - Adapter Helpers Functions -

	public func dequeueCell(inTable table: UITableView, at indexPath: IndexPath?) -> UITableViewCell {
		guard let indexPath = indexPath else {
            let castedCell = modelViewType as! UITableViewCell.Type
			let cellInstance = castedCell.init()
			return cellInstance
		}
        return table.dequeueReusableCell(withIdentifier: reusableViewIdentifier, for: indexPath)
	}

	public func registerReusableCellViewForDirector(_ director: TableDirector) -> Bool {
        let id = reusableViewIdentifier
		guard director.cellReuseIDs.contains(id) == false else {
			return false
		}
        
        registerReusableViewAsType(forDirector: director)
		director.cellReuseIDs.insert(id)
		return true
	}
    
    private func registerReusableViewAsType(forDirector director: TableDirector) {
        switch reusableViewLoadSource {
        case .fromStoryboard:
            // nothing to do
            break
            
        case .fromXib(let name, let bundle):
            let srcBundle = (bundle ?? Bundle.init(for: Cell.self))
            let srcNib = UINib(nibName: (name ?? reusableViewIdentifier), bundle: srcBundle)
            director.table?.register(srcNib, forCellReuseIdentifier: reusableViewIdentifier)
            
        case .fromClass:
            director.table?.register(Cell.self, forCellReuseIdentifier: reusableViewIdentifier)
            
        }
    }

	// MARK: - Supporting Functions -

	@discardableResult
	public func dispatchEvent(_ kind: TableAdapterEventID, model: Any?, cell: ReusableViewProtocol?, path: IndexPath?, params: Any?...) -> Any? {
		switch kind {
		case .dequeue:
			events.dequeue?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))

		case .rowHeight:
			return events.rowHeight?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .rowHeightEstimated:
			return events.rowHeightEstimated?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .canEditRow:
			return events.canEditRow?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))

		case .commitEdit:
			return events.commitEdit?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path), params.first as! UITableViewCell.EditingStyle)
			
		case .editActions:
			return events.editActions?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .canMoveRow:
			return events.canMoveRow?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .moveRow:
			events.moveRow?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path), params.first as! IndexPath)
			
		case .indentLevel:
			return events.indentLevel?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .prefetch:
			events.prefetch?(model as! [Model], params.first as! [IndexPath])
			
		case .cancelPrefetch:
			events.cancelPrefetch?(model as! [Model], params.first as! [IndexPath])
			
		case .willDisplay:
			events.willDisplay?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .shouldSpringLoad:
			return events.shouldSpringLoad?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .tapOnAccessory:
			events.tapOnAccessory?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .willSelect:
			return events.willSelect?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .tap:
			return events.didSelect?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .willDeselect:
			return events.willDeselect?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .didDeselect:
			return events.didDeselect?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .willBeginEdit:
			return events.willBeginEdit?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .didEndEdit:
			events.didEndEdit?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .editStyle:
			return events.editStyle?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .deleteConfirmTitle:
			return events.deleteConfirmTitle?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .editShouldIndent:
			return events.editShouldIndent?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .moveAdjustDestination:
			return events.moveAdjustDestination?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path),
			params.first as! IndexPath)
			
		case .endDisplay:
			return events.endDisplay?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .shouldShowMenu:
			return events.shouldShowMenu?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .canPerformMenuAction:
			return events.canPerformMenuAction?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path),
												params.first as! Selector,
												params.last as Any)
			
		case .performMenuAction:
			events.performMenuAction?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path),
									  params.first as! Selector,
									  params.last as Any)

			
		case .shouldHighlight:
			return events.shouldHighlight?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .didHighlight:
			events.didHighlight?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .didUnhighlight:
			events.didUnhighlight?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .canFocus:
			return events.canFocus?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			
		case .leadingSwipeActions:
			if #available(iOS 11, *) {
				return events.leadingSwipeActions?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			}
			
		case .trailingSwipeActions:
			if #available(iOS 11, *) {
				return events.trailingSwipeActions?(TableCellAdapter.Event(item: model, cell: cell, indexPath: path))
			}

		}

		return nil
	}

}
