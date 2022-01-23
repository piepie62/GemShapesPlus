package gemshapesplus
{
	import Bezel.Bezel;
	import Bezel.BezelCoreMod;
	import Bezel.Events.EventTypes;
	import Bezel.Events.IngameNewSceneEvent;
	import Bezel.Lattice.Lattice;
	import Bezel.Logger;
	import flash.display.MovieClip;
	import gemshapesplus.gcfw.ShapeAdder;
	import gemshapesplus.gccs.steam.ShapeAdder;
	
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
		[Embed(source = "../../shapes/teardrop_seal.svg")] public static const g18:Class;
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
		[Embed(source = "../../shapes/cube.svg")] public static const g29:Class;
		[Embed(source = "../../shapes/snowflake.svg")] public static const g30:Class;
		[Embed(source = "../../shapes/teardrop.svg")] public static const g31:Class;
		[Embed(source = "../../shapes/briolette.svg")] public static const g32:Class;
		[Embed(source = "../../shapes/corkscrew.svg")] public static const g33:Class;
		[Embed(source = "../../shapes/hole.svg")] public static const g34:Class;
		[Embed(source = "../../shapes/shard.svg")] public static const g35:Class;
		[Embed(source = "../../shapes/toast.svg")] public static const g36:Class;
		
		public static const MAX_EXTRA_GRADE:int = 36;
		
		CONFIG::release
		public static const GRADE_ORDER:Vector.<int> = new <int>[1,25, 31, 18,2,24,3,4,5,16,20,19,6,26,7,14,17,8,9,15,10,13,23,21,22,11,27,28,12, 29, 30, 32, 33, 34, 35, 36];
		CONFIG::debug
		public static const GRADE_ORDER:Vector.<int> = new <int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36];
		
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

			if (bezel.mainLoader.gameClassFullyQualifiedName == "com.giab.games.gcfw.Main")
			{
				gemshapesplus.gcfw.ShapeAdder.addShapes(gameObjects.GV.gemBitmapCreator.mc);
			}
			else
			{
				gemshapesplus.gccs.steam.ShapeAdder.addShapes(gameObjects.GV.gemBitmapCreator.mc);
			}
		}
		
		CONFIG::release
		public function bind(loader:Bezel, gameObjects:Object):void
		{
			if (bezel.mainLoader.gameClassFullyQualifiedName == "com.giab.games.gcfw.Main")
			{
				gemshapesplus.gcfw.ShapeAdder.addShapes(gameObjects.GV.gemBitmapCreator.mc);
			}
			else
			{
				gemshapesplus.gccs.steam.ShapeAdder.addShapes(gameObjects.GV.gemBitmapCreator.mc);
			}
		}

		CONFIG::release
		public function unload(loader:Bezel, gameObjects:Object):void
		{
			if (bezel.mainLoader.gameClassFullyQualifiedName == "com.giab.games.gcfw.Main")
			{
				gemshapesplus.gcfw.ShapeAdder.removeShapes(gameObjects.GV.gemBitmapCreator.mc);
			}
			else
			{
				gemshapesplus.gccs.steam.ShapeAdder.removeShapes(gameObjects.GV.gemBitmapCreator.mc);
			}
		}
		
		CONFIG::debug
		public function unload():void
		{
			bezel.removeEventListener(EventTypes.INGAME_NEW_SCENE, this.onNewScene);

			if (bezel.mainLoader.gameClassFullyQualifiedName == "com.giab.games.gcfw.Main")
			{
				gemshapesplus.gcfw.ShapeAdder.removeShapes(gameObjects.GV.gemBitmapCreator.mc);
			}
			else
			{
				gemshapesplus.gccs.steam.ShapeAdder.removeShapes(gameObjects.GV.gemBitmapCreator.mc);
			}
		}
		
		public function loadCoreMod(lattice:Lattice): void
		{
			GemShapesPlusCoreMod.installCoremods(lattice);
		}
		
		CONFIG::debug
		public function onNewScene(e:IngameNewSceneEvent): void
		{
			gameObjects.GV.ingameCore.changeMana(100000000000000, false, false);
		}
	}
	
}
