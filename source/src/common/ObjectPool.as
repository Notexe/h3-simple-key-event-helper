// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.ObjectPool

package common {
public class ObjectPool {

	private var m_type:Class;
	private var m_onNewObjectAllocated:Function;
	private var m_objectsAvailable:Array = [];

	public function ObjectPool(_arg_1:Class, _arg_2:int, _arg_3:Function = null) {
		var _local_5:*;
		super();
		this.m_type = _arg_1;
		this.m_onNewObjectAllocated = _arg_3;
		var _local_4:int;
		while (_local_4 < _arg_2) {
			_local_5 = new this.m_type();
			if (this.m_onNewObjectAllocated != null) {
				this.m_onNewObjectAllocated(_local_5);
			}

			this.m_objectsAvailable.push(_local_5);
			_local_4++;
		}

	}

	public function acquireObject():* {
		var _local_1:*;
		if (this.m_objectsAvailable.length > 0) {
			_local_1 = this.m_objectsAvailable.pop();
		} else {
			_local_1 = new this.m_type();
			if (this.m_onNewObjectAllocated != null) {
				this.m_onNewObjectAllocated(_local_1);
			}

		}

		return (_local_1);
	}

	public function releaseObject(_arg_1:*):void {
		this.m_objectsAvailable.push(_arg_1);
	}


}
}//package common

