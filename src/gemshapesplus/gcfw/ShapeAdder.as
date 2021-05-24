package gemshapesplus.gcfw 
{
	import com.giab.games.gcfw.mcDyn.McGem;
	import com.giab.games.gcfw.mcVfx.McVfxTowerShotGlare;
	import flash.automation.AutomationAction;
	import flash.geom.Rectangle;
	import gemshapesplus.GemShapesPlusCoreMod;
	import gemshapesplus.GemShapesPlusMod;
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
			var rect:Rectangle = mc.getRect(mc);
			var origWidth:Number = mc.width, origHeight:Number = mc.height;
			
			mc.removeChild(mc.glare);
			mc.glare = new ReplacementGlare(mc.glare);
			mc.addChild(mc.glare);
			
			mc.glare.x = (origWidth - mc.glare.width) / 2 + rect.x;
			mc.glare.y = (origHeight - mc.glare.height) / 2 + rect.y;
			
			mc.removeChild(mc.blackLayer);
			mc.blackLayer = new ReplacementBlackLayer(mc.blackLayer);
			mc.addChildAt(mc.blackLayer, 0);
			
			mc.blackLayer.x = (origWidth - mc.blackLayer.width) / 2 + rect.x;
			mc.blackLayer.y = (origHeight - mc.blackLayer.height) / 2 + rect.y;
		}
		
		public static function addVfxShapes(mc:McVfxTowerShotGlare):void
		{
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
