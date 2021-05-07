package gemshapesplus.gccs.steam 
{
	import com.giab.games.gccs.steam.mcDyn.McGem;
	import com.giab.games.gccs.steam.mcVfx.McVfxTowerShotGlare;
	import flash.geom.Rectangle;
	import gemshapesplus.shapemodifiers.ReplacementBlackLayer;
	import gemshapesplus.shapemodifiers.ReplacementGlare;
	/**
	 * ...
	 * @author Chris
	 */
	public class ShapeAdder 
	{
		public static function addShapes(mc:McGem):void 
		{
			mc.glare = new ReplacementGlare(mc.glare);
			mc.addChild(mc.glare);
			
			var rect:Rectangle = mc.getRect(mc);
			
			mc.glare.x = (mc.width - mc.glare.width) / 2 + rect.x;
			mc.glare.y = (mc.height - mc.glare.height) / 2 + rect.y;
			
			mc.blackLayer = new ReplacementBlackLayer(mc.blackLayer);
			mc.addChildAt(mc.blackLayer, 0);
			
			mc.blackLayer.x = (mc.width - mc.blackLayer.width) / 2 + rect.x;
			mc.blackLayer.y = (mc.height - mc.blackLayer.height) / 2 + rect.y;
		}
		
		public static function addVfxShapes(mc:McVfxTowerShotGlare):void
		{
			// TODO: Figure out why this doesn't work and how to fix it
			return;
			
			mc.mcColor = new ReplacementBlackLayer(mc.mcColor);
			mc.addChildAt(mc.mcColor, 0);
			
			var rect:Rectangle = mc.getRect(mc);
			
			mc.mcColor.x = - rect.x;
			mc.mcColor.y = - rect.y;
		}
	}

}
