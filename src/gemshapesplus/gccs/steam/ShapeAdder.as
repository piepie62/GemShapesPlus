package gemshapesplus.gccs.steam 
{
	import com.giab.games.gccs.steam.mcDyn.McGem;
	import com.giab.games.gccs.steam.mcVfx.McVfxTowerShotGlare;
	import flash.geom.Rectangle;
	import gemshapesplus.shapemodifiers.ReplacementBlackLayer;
	import gemshapesplus.shapemodifiers.ReplacementGlare;
	import gc_cs_steam_fla.gemGlare_9;
	import gc_cs_steam_fla.gemColorBodyMain_5;
	/**
	 * ...
	 * @author Chris
	 */
	public class ShapeAdder 
	{
		public static function addShapes(o:Object):void
		{
			var mc:McGem = o as McGem;
			var rect:Rectangle = mc.getRect(mc);
			var origWidth:Number = mc.width, origHeight:Number = mc.height;
			
			mc.removeChild(mc.glare);
			mc.removeChild(mc.blackLayer);
			
			mc.glare = new ReplacementGlare(mc.glare);
			mc.addChild(mc.glare);
			
			mc.glare.x = (origWidth - mc.glare.width) / 2 + rect.x;
			mc.glare.y = (origHeight - mc.glare.height) / 2 + rect.y;
			
			mc.blackLayer = new ReplacementBlackLayer(mc.blackLayer);
			mc.addChildAt(mc.blackLayer, 0);
			
			mc.blackLayer.x = (origWidth - mc.blackLayer.width) / 2 + rect.x;
			mc.blackLayer.y = (origHeight - mc.blackLayer.height) / 2 + rect.y;
		}

		public static function removeShapes(o:Object):void
		{
			var mc:McGem = o as McGem;
			mc.removeChild(mc.glare);
			mc.glare = new gemGlare_9();
			mc.glare.scaleX = mc.glare.scaleY = 1.8863525390625;
			mc.glare.x = 27;
			mc.glare.y = 28.05;
			mc.addChild(mc.glare);

			mc.removeChild(mc.blackLayer);
			mc.blackLayer = new gemColorBodyMain_5();
			mc.blackLayer.scaleX = mc.blackLayer.scaleY = 1.8863525390625;
			mc.blackLayer.x = 27;
			mc.blackLayer.y = 28.05;
			mc.addChild(mc.blackLayer);
		}
		
		public static function addVfxShapes(o:Object):void
		{
			var mc:McVfxTowerShotGlare = o as McVfxTowerShotGlare;
			// TODO: Figure out why this doesn't work and how to fix it
			var rect:Rectangle = mc.getRect(mc);
			var origWidth:Number = mc.width, origHeight:Number = mc.height;
			var origScaleX:Number = mc.scaleX, origScaleY:Number = mc.scaleY;
			
			mc.removeChild(mc.mcColor);
			
			var filters:Array = mc.mcColor.filters;
			
			mc.mcColor = new ReplacementBlackLayer(mc.mcColor);
			mc.addChildAt(mc.mcColor, 0);
			
			mc.mcColor.filters = filters;
			
			mc.mcColor.x = (origWidth - mc.mcColor.width) / 2 + rect.x;
			mc.mcColor.y = (origHeight - mc.mcColor.height) / 2 + rect.y;
			
			mc.scaleX = origScaleX;
			mc.scaleY = origScaleY;
		}
	}

}
