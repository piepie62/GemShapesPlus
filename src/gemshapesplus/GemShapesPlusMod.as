package gemshapesplus
{
	import Bezel.Bezel;
	import Bezel.BezelCoreMod;
	import Bezel.Events.EventTypes;
	import Bezel.Events.IngameNewSceneEvent;
	import Bezel.Lattice.Lattice;
	import Bezel.Logger;
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Chris
	 */
	public class GemShapesPlusMod extends MovieClip implements BezelCoreMod 
	{
		public function get BEZEL_VERSION():String { return "1.0.0"; }
		public function get VERSION():String { return "0.0.1"; }
		public function get MOD_NAME():String { return "Gem Shapes Plus"; }
		public function get COREMOD_VERSION():String { return GemShapesPlusCoreMod.VERSION; }
		
		public static var logger:Logger;
		public static var bezel:Bezel;
		
		private var gameObjects:Object;
		
		[Embed(source = "../../shapes/g13.svg")] public static const g13:Class;
		[Embed(source = "../../shapes/g14.svg")] public static const g14:Class;
		[Embed(source = "../../shapes/g15.svg")] public static const g15:Class;
		[Embed(source = "../../shapes/g16.svg")] public static const g16:Class;
		[Embed(source = "../../shapes/g17.svg")] public static const g17:Class;
		[Embed(source = "../../shapes/g18.svg")] public static const g18:Class;
		[Embed(source = "../../shapes/g19.svg")] public static const g19:Class;
		[Embed(source = "../../shapes/g20.svg")] public static const g20:Class;
		[Embed(source = "../../shapes/g21.svg")] public static const g21:Class;
		[Embed(source = "../../shapes/g22.svg")] public static const g22:Class;
		[Embed(source = "../../shapes/g23.svg")] public static const g23:Class;
		[Embed(source = "../../shapes/g24.svg")] public static const g24:Class;
		[Embed(source = "../../shapes/g25.svg")] public static const g25:Class;
		
		public static const MAX_EXTRA_GRADE:int = 25;
		
		public function GemShapesPlusMod()
		{
			logger = Logger.getLogger("GemShapesPlus");
		}
		
		CONFIG::debug
		public function bind(loader:Bezel, gameObjects:Object):void
		{
			bezel = loader;
			bezel.addEventListener(EventTypes.INGAME_NEW_SCENE, this.onNewScene);
			this.gameObjects = gameObjects;
		}
		
		CONFIG::release
		public function bind(loader:Bezel, gameObjects:Object):void
		{
		}
		
		public function unload():void
		{
		}
		
		public function loadCoreMod(lattice:Lattice): void
		{
			GemShapesPlusCoreMod.installCoremods(lattice);
		}
		
		public function onNewScene(e:IngameNewSceneEvent): void
		{
			gameObjects.GV.ingameCore.changeMana(100000000000000, false, false);
		}
		
	}
	
}
