package
{
	import com.adobe.serialization.json.JSON;
	
	import flash.display.Sprite;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.net.XMLSocket;
	
	public class RawPixelsTest extends Sprite
	{
		private var socket:XMLSocket = new XMLSocket();
		public function RawPixelsTest()
		{
			
			socket.connect('localhost', 7000);
			socket.addEventListener(DataEvent.DATA, onData);
			socket.addEventListener(Event.CONNECT, onConnect);
		}
		
		public function send (data:Object):void
		{
			socket.send(com.adobe.serialization.json.JSON.encode(data));
		}
		
		
		private function debug():void
		{
			// create a room
			this.send({
				c: 'createRoom',
				name: 'The most awesome room ever'
			});
		}
		
		protected function onConnect(event:Event):void
		{
			this.debug();
		}
		
		protected function onData(event:DataEvent):void
		{
			var json:Object = com.adobe.serialization.json.JSON.decode(event.data);
			trace('command', json.c);
		}
	}
}