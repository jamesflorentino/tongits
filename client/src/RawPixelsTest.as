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
		
		protected function onConnect(event:Event):void
		{
			var o:Object = {
				name: "James and Rico's Gambling room",
				c: 'createRoom'
			};
			
			var jsonString:String = com.adobe.serialization.json.JSON.encode(o);
			socket.send(jsonString);
			
		}
		protected function onData(event:DataEvent):void
		{
			var json:Object = com.adobe.serialization.json.JSON.decode(event.data);
			trace('command', json.c);
		}
	}
}