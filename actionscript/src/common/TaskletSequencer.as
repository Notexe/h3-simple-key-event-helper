// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.TaskletSequencer

package common {
import flash.display.Sprite;
import flash.events.Event;
import flash.utils.getTimer;

public class TaskletSequencer extends Sprite {

	public static const COMPLETE:String = "complete";
	private static var s_evtComplete:Event = new Event(COMPLETE);
	private static var s_instance:TaskletSequencer;

	private const FUNCTION_AVERAGE_LONG_CALL_TIME_MS:Number = 1;
	private const m_queueMaxProcessingTime_ms:Number = 50;
	private const m_queueMaxProcessingTimeVR_ms:Number = 4;

	public var processingTime_ms:Number = 0.25;
	public var debug_forceOnlyOneCallPerFrame:Boolean = false;
	private var m_nextQueue:Queue = new Queue();
	private var m_stack:Stack = new Stack();
	private var m_isProcessing:Boolean = false;
	private var m_nLastUpdateId:int = -1;


	public static function getGlobalInstance():TaskletSequencer {
		if (s_instance == null) {
			s_instance = new (TaskletSequencer)();
			s_instance.startDaemon();
		}

		return (s_instance);
	}


	public function addChunk(_arg_1:Function):void {
		this.m_nextQueue.enqueue(_arg_1);
	}

	public function clear():void {
		this.m_stack.clear();
		this.m_nextQueue.clear();
	}

	public function update():void {
		if (((this.m_isProcessing) || ((this.m_stack.isEmpty()) && (this.m_nextQueue.isEmpty())))) {
			return;
		}

		this.m_isProcessing = true;
		var actualProcessingTime_ms:Number = Math.max((this.processingTime_ms - this.FUNCTION_AVERAGE_LONG_CALL_TIME_MS), 0);
		var currentTime_ms:int = getTimer();
		var startTime_ms:int = currentTime_ms;
		var maxTime_ms:int = (currentTime_ms + actualProcessingTime_ms);
		var debug_forceOnlyOneCallPerFrame:Boolean;
		if (((!(this.m_stack.isEmpty())) && (!(this.m_nextQueue.isEmpty())))) {
			while ((!(this.m_nextQueue.isEmpty()))) {
				this.m_stack.getBottom().enqueue(this.m_nextQueue.dequeue());
			}

		}

		while (true) {
			if (!this.m_nextQueue.isEmpty()) {
				this.m_stack.push(this.m_nextQueue);
				this.m_nextQueue = new Queue();
			}

			if (this.m_stack.isEmpty()) break;
			try {
				(this.m_stack.getTop().dequeue()());
			} catch (err:Error) {
				trace(("error in TaskletSequencer chunk --> " + err.getStackTrace()));
			}

			if (this.m_stack.getTop().isEmpty()) {
				this.m_stack.pop();
			}

			currentTime_ms = getTimer();
			if (((currentTime_ms >= maxTime_ms) || (debug_forceOnlyOneCallPerFrame))) break;
		}

		if (!this.m_nextQueue.isEmpty()) {
			this.m_stack.push(this.m_nextQueue);
			this.m_nextQueue = new Queue();
		}

		this.m_isProcessing = false;
		if (this.m_stack.isEmpty()) {
			dispatchEvent(s_evtComplete);
		}

	}

	private function startDaemon():void {
		addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
	}

	private function onEnterFrame(_arg_1:Event):void {
		var _local_2:int = ControlsMain.getFrameCount();
		if (this.m_nLastUpdateId == _local_2) {
			return;
		}

		this.m_nLastUpdateId = _local_2;
		if (ControlsMain.isVrModeActive()) {
			this.processingTime_ms = this.m_queueMaxProcessingTimeVR_ms;
		} else {
			this.processingTime_ms = this.m_queueMaxProcessingTime_ms;
		}

		this.update();
	}


}
}//package common


class Queue {

	/*private*/
	internal var m_functions:Vector.<Function> = new Vector.<Function>();


	public function enqueue(_arg_1:Function):void {
		this.m_functions.push(_arg_1);
	}

	public function dequeue():Function {
		return (this.m_functions.shift());
	}

	public function isEmpty():Boolean {
		return (this.m_functions.length == 0);
	}

	public function clear():void {
		this.m_functions.length = 0;
	}


}

class Stack {

	/*private*/
	internal var m_queues:Vector.<Queue> = new Vector.<Queue>();


	public function push(_arg_1:Queue):void {
		this.m_queues.push(_arg_1);
	}

	public function pop():Queue {
		return (this.m_queues.pop());
	}

	public function getTop():Queue {
		if (this.isEmpty()) {
			return (null);
		}

		return (this.m_queues[(this.m_queues.length - 1)]);
	}

	public function getBottom():Queue {
		if (this.isEmpty()) {
			return (null);
		}

		return (this.m_queues[0]);
	}

	public function isEmpty():Boolean {
		return (this.m_queues.length == 0);
	}

	public function clear():void {
		this.m_queues.length = 0;
	}


}


