package gemshapesplus.shapemodifiers 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import gemshapesplus.GemShapesPlusMod;
	/**
	 * ...
	 * @author Chris
	 */
	public class ReplacementBlackLayer extends MovieClip
	{
		private var shouldBeFrame:int;
		
		private var g1:DisplayObject;
		private var g2:DisplayObject;
		private var g3:DisplayObject;
		private var g4:DisplayObject;
		private var g5:DisplayObject;
		private var g6:DisplayObject;
		private var g7:DisplayObject;
		private var g8:DisplayObject;
		private var g9:DisplayObject;
		private var g10:DisplayObject;
		private var g11:DisplayObject;
		private var g12:DisplayObject;
		private var g13:Sprite;
		private var g14:Sprite;
		private var g15:Sprite;
		private var g16:Sprite;
		private var g17:Sprite;
		private var g18:Sprite;
		private var g19:Sprite;
		private var g20:Sprite;
		private var g21:Sprite;
		private var g22:Sprite;
		private var g23:Sprite;
		private var g24:Sprite;
		private var g25:Sprite;
		private var g26:Sprite;
		private var g27:Sprite;
		private var g28:Sprite;
		
		public override function set visible(val:Boolean):void
		{
			super.visible = val;
			this.setVisible(this.shouldBeFrame, val);
		}
		
		public function ReplacementBlackLayer(oldBlackLayer:MovieClip) 
		{
			var scaleX:Number = oldBlackLayer.scaleX, scaleY:Number = oldBlackLayer.scaleY;
			
			this.shouldBeFrame = oldBlackLayer.currentFrame;
			
			var i:int;
			var varName:String;
			
			for (i = 1; i <= 12; i++)
			{
				varName = "g" + i;
				oldBlackLayer.gotoAndStop(i);
				this[varName] = new Shape();
				this[varName].graphics.drawGraphicsData((oldBlackLayer.getChildAt(0) as Shape).graphics.readGraphicsData());
			}

			for (i = 13; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
			{
				varName = "g" + i;
				this[varName] = new GemShapesPlusMod[varName]();
				
				this[varName].transform.colorTransform = new ColorTransform(0, 0, 0);
			}
			
			var width:Number = Number.MIN_VALUE, height:Number = Number.MIN_VALUE;
			
			for (i = 1; i < GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
			{
				varName = "g" + i;
				width = Math.max(this[varName].width, width);
				height = Math.max(this[varName].height, height);
			}
			
			var rect:Rectangle;
			
			for (i = 1; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
			{
				varName = "g" + i;
				rect = this[varName].getRect(this[varName]);
				this.addChild(this[varName]);
				this[varName].x = (width - this[varName].width) / 2 - rect.x;
				this[varName].y = (height - this[varName].height) / 2 - rect.y;
			}
			
			this.setVisible(this.shouldBeFrame, this.visible);
			
			this.scaleX = scaleX;
			this.scaleY = scaleY;
		}
		
		public override function gotoAndStop(frame:Object, scene:String = null):void
		{
			if (frame is String)
			{
				throw new ArgumentError("gemshapesplus.shapemodifiers.ReplacementBlackLayer cannot support string frames");
			}
			if (scene != null)
			{
				throw new ArgumentError("gemshapesplus.shapemodifiers.ReplacementBlackLayer doesn't know what a non-null scene means");
			}
			
			var frameNum:int = frame as int;
			
			this.shouldBeFrame = frameNum;
			
			this.setVisible(this.shouldBeFrame, this.visible);
		}
		
		private function setVisible(frame:int, val:Boolean):void
		{
			var activeSprite:int = Math.min(GemShapesPlusMod.MAX_EXTRA_GRADE, frame);
			
			for (var i:int = 0; i < GemShapesPlusMod.GRADE_ORDER.length; i++)
			{
				var image:int = GemShapesPlusMod.GRADE_ORDER[i];
				if (i + 1 == activeSprite)
				{
					this["g" + image].visible = val;
				}
				else
				{
					this["g" + image].visible = false;
				}
			}
		}
		
	}

}
