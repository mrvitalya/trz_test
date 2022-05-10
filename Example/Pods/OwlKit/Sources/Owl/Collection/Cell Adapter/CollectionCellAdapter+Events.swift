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

public extension CollectionCellAdapter {

	struct Event {

		/// Index path of represented context's cell instance
		public let indexPath: IndexPath?

		/// Represented model instance
		public let element: Model?

		/// Managed source collection
        public var collection: UICollectionView? {
            guard let cell = (cell as? UICollectionViewCell),
                let collection = cell.superview as? UICollectionView else {
                    return nil
            }
            return collection
        }

		/// Managed source collection's bounds size
		public var collectionSize: CGSize? {
            return collection?.bounds.size
		}

		/// Represented cell instance.
		/// Depending from the source event where the context is generated it maybe nil.
		/// When not `nil` it's stricly typed to its parent adapter cell's definition.
		public var cell: Cell?
        
		/// Initialize a new context from a source event.
		/// Instances of the Context are generated automatically and received from events; you don't need to allocate on your own.
		///
		/// - Parameters:
		///   - model: source generic model
		///   - cell: source generic cell
		///   - path: cell's path
		///   - collection: parent cell's collection instance
		internal init(element: Any?, cell: Any?, path: IndexPath?) {
			self.element = element as? Model
			self.cell = cell as? Cell
			self.indexPath = path
		}

	}

	struct EventsSubscriber {
		public var dequeue: ((Event) -> Void)? = nil
		public var shouldSelect: ((Event) -> Bool)? = nil
		public var shouldDeselect: ((Event) -> Bool)? = nil
		public var didSelect: ((Event) -> Void)? = nil
		public var didDeselect: ((Event) -> Void)? = nil
		public var didHighlight: ((Event) -> Void)? = nil
		public var didUnhighlight: ((Event) -> Void)? = nil
		public var shouldHighlight: ((Event) -> Bool)? = nil
		public var willDisplay: ((Event) -> Void)? = nil
		public var endDisplay: ((Event) -> Void)? = nil
		public var shouldShowEditMenu: ((Event) -> Bool)? = nil
		public var canPerformEditAction: ((Event) -> Bool)? = nil
		public var performEditAction: ((_ ctx: Event, _ selector: Selector, _ sender: Any?) -> Void)? = nil
		public var canFocus: ((Event) -> Bool)? = nil
		public var itemSize: ((Event) -> CGSize)? = nil
		//var generateDragPreview: ((EventContext) -> UIDragPreviewParameters?)? = nil
		//var generateDropPreview: ((EventContext) -> UIDragPreviewParameters?)? = nil
		public var prefetch: ((_ items: [Model], _ paths: [IndexPath]) -> Void)? = nil
		public var cancelPrefetch: ((_ items: [Model], _ paths: [IndexPath]) -> Void)? = nil
		public var shouldSpringLoad: ((Event) -> Bool)? = nil
	}

}

public enum CollectionAdapterEventID: Int {
	case dequeue
	case shouldSelect
	case shouldDeselect
	case didSelect
	case didDeselect
	case didHighlight
	case didUnhighlight
	case shouldHighlight
	case willDisplay
	case endDisplay
	case shouldShowEditMenu
	case canPerformEditAction
	case performEditAction
	case canFocus
	case itemSize
	//case generateDragPreview
	//case generateDropPreview
	case prefetch
	case cancelPrefetch
	case shouldSpringLoad
}
