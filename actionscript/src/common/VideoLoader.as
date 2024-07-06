// Decompiled by AS3 Sorcerer 6.78
// www.buraks.com/as3sorcerer

//common.VideoLoader

package common {
import flash.display.MovieClip;
import flash.net.NetConnection;
import flash.media.Video;
import flash.net.NetStream;
import flash.events.NetStatusEvent;
import flash.events.Event;

import scaleform.gfx.*;

public class VideoLoader extends MovieClip {

	private var m_startCallback:Function;
	private var m_stopCallback:Function;
	private var m_subCallback:Function;
	private var m_metadataCallback:Function;
	private var m_netConnection:NetConnection;
	private var m_netStream:Object;
	private var m_video:Video;
	private var m_inMemory:Boolean;
	private var m_TrackIndex:int = -1;
	private var m_duration:Number = -1;
	private var m_clearOnStop:Boolean = true;

	public function VideoLoader() {
		this.m_inMemory = false;
		this.m_netConnection = new NetConnection();
		this.m_netConnection.connect(null);
		var _local_1:NetStream = new NetStream(this.m_netConnection);
		this.m_netStream = _local_1;
		this.m_netStream.openTimeout = 0;
		this.m_netStream.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
		this.m_video = new Video();
		this.m_video.attachNetStream(_local_1);
		addChild(this.m_video);
		var _local_2:Object = {};
		_local_2.onMetaData = this.onMetaData;
		_local_2.onSubtitle = this.onSubtitles;
		this.m_netStream.client = _local_2;
		this.m_duration = 0;
		this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
	}

	public function onMetaData(_arg_1:Object):void {
		Log.info(Log.ChannelVideo, this, ((("Video Loader on MetaData track: " + this.m_TrackIndex) + " duration ") + _arg_1.duration));
		this.m_duration = _arg_1.duration;
		if (this.m_TrackIndex != -1) {
			this.m_netStream.subtitleTrack = this.m_TrackIndex;
		}

		if (this.m_metadataCallback != null) {
			this.m_metadataCallback(_arg_1);
		}

	}

	public function onSubtitles(_arg_1:String, _arg_2:String = ""):void {
		Log.info(Log.ChannelVideo, this, ((("Subtitle (Loader): [" + _arg_2) + "] ") + _arg_1));
		if (this.m_subCallback != null) {
			this.m_subCallback(_arg_1, _arg_2);
		}

	}

	public function setSubCallback(_arg_1:Function):void {
		this.m_subCallback = _arg_1;
	}

	public function setMetadataCallback(_arg_1:Function):void {
		this.m_metadataCallback = _arg_1;
	}

	public function playVideo(_arg_1:String, _arg_2:Number, _arg_3:Function, _arg_4:Function):void {
		this.stopStream();
		this.m_TrackIndex = _arg_2;
		this.m_startCallback = _arg_3;
		this.m_stopCallback = _arg_4;
		this.startStream(_arg_1);
	}

	public function stopVideo():void {
		this.stopStream();
	}

	public function seekAbsoluteVideo(_arg_1:Number):void {
		Log.info(Log.ChannelVideo, this, "Video seekAbsoluteVideo");
		this.m_netStream.seek(_arg_1);
	}

	public function seekOffsetVideo(_arg_1:Number):void {
		Log.info(Log.ChannelVideo, this, ("Video seekOffsetVideo " + _arg_1));
		this.m_netStream.seek((this.m_netStream.time + _arg_1));
	}

	public function getVideoCurrentTime():Number {
		if (((!(this.m_netStream)) || (!(this.m_netStream.time)))) {
			return (-1);
		}

		return (this.m_netStream.time);
	}

	public function setPause(_arg_1:Boolean):void {
		if (_arg_1) {
			Log.info(Log.ChannelVideo, this, "Video Loader netstream paused");
			this.m_netStream.pause();
		} else {
			Log.info(Log.ChannelVideo, this, "Video Loader netstream resumed");
			this.m_netStream.resume();
		}

	}

	public function setLoop(_arg_1:Boolean):void {
		this.m_netStream.loop = _arg_1;
	}

	public function getClearOnStop(_arg_1:Boolean):Boolean {
		return (this.m_clearOnStop);
	}

	public function setClearOnStop(_arg_1:Boolean):void {
		this.m_clearOnStop = _arg_1;
	}

	public function setInMemory(_arg_1:Boolean):void {
		this.m_inMemory = _arg_1;
	}

	public function getNetStream():Object {
		return (this.m_netStream);
	}

	public function getVideoDuration():Number {
		return (this.m_duration);
	}

	private function startStream(_arg_1:String):void {
		Log.info(Log.ChannelVideo, this, "Video Loader netstream start");
		this.m_video.clear();
		var _local_2:String = ((this.m_inMemory) ? "[GFXMRV]" : "[GFXV]");
		this.m_netStream.play((_local_2 + _arg_1));
	}

	private function sendStart():void {
		if (this.m_startCallback != null) {
			this.m_startCallback();
			this.m_startCallback = null;
		}

	}

	private function stopStream():void {
		if (this.m_clearOnStop) {
			this.m_video.clear();
		}

		this.m_netStream.close();
		this.m_duration = 0;
		Log.info(Log.ChannelVideo, this, "Video Loader netstream stop");
	}

	private function sendStop():void {
		if (this.m_stopCallback != null) {
			this.m_stopCallback();
			this.m_stopCallback = null;
		}

	}

	private function netStatusHandler(_arg_1:NetStatusEvent):void {
		Log.info(Log.ChannelVideo, this, ("Video Loader netstream event " + _arg_1.info.code));
		switch (_arg_1.info.code) {
			case "NetStream.Play.Start":
				this.sendStart();
				return;
			case "NetStream.Play.Stop":
				if (this.m_clearOnStop) {
					this.m_video.clear();
				}

				this.sendStop();
				return;
			case "NetStream.Play.StreamNotFound":
				return;
		}

	}

	private function onRemoved(_arg_1:Event):void {
		this.stopVideo();
	}


}
}//package common

