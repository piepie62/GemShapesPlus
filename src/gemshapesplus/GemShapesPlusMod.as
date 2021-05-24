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
		
		[Embed(source = "../../shapes/eight_petal.svg")] public static const g13:Class;
		[Embed(source = "../../shapes/heart.svg")] public static const g14:Class;
		[Embed(source = "../../shapes/spiky.svg")] public static const g15:Class;
		[Embed(source = "../../shapes/six_petal.svg")] public static const g16:Class;
		[Embed(source = "../../shapes/octagon.svg")] public static const g17:Class;
		[Embed(source = "../../shapes/teardrop.svg")] public static const g18:Class;
		[Embed(source = "../../shapes/diamond.svg")] public static const g19:Class;
		[Embed(source = "../../shapes/four_petal.svg")] public static const g20:Class;
		[Embed(source = "../../shapes/crescent.svg")] public static const g21:Class;
		[Embed(source = "../../shapes/swirly_drop.svg")] public static const g22:Class;
		[Embed(source = "../../shapes/eye.svg")] public static const g23:Class;
		[Embed(source = "../../shapes/three_petal.svg")] public static const g24:Class;
		[Embed(source = "../../shapes/potato.svg")] public static const g25:Class;
		[Embed(source = "../../shapes/shield.svg")] public static const g26:Class;
		[Embed(source = "../../shapes/axe.svg")] public static const g27:Class;
		[Embed(source = "../../shapes/filled_axe.svg")] public static const g28:Class;
		
		
		public static const MAX_EXTRA_GRADE:int = 28;
		
		public static const GRADE_ORDER:Vector.<int> = new <int>[1,25,18,2,24,3,4,5,16,20,19,6,26,7,14,17,8,9,15,10,13,23,21,22,11,27,28,12];
		
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
