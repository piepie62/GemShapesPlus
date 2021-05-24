package gemshapesplus.shapemodifiers 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.GraphicsBitmapFill;
	import flash.display.GraphicsPath;
	import flash.display.IGraphicsData;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import gemshapesplus.GemShapesPlusMod;
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Chris
	 */
	public class ReplacementGlare extends MovieClip
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
		
		private var bmps:Vector.<BitmapData>;
		
		public override function set visible(val:Boolean):void
		{
			super.visible = val;
			this.setVisible(this.shouldBeFrame, val);
		}
		
		public function ReplacementGlare(oldGlare:MovieClip) 
		{
			this.bmps = new Vector.<BitmapData>();
			var scaleX:Number = oldGlare.scaleX, scaleY:Number = oldGlare.scaleY;
			
			this.shouldBeFrame = oldGlare.currentFrame;
			
			var i:int;
			var varName:String;
			
			for (i = 1; i <= 12; i++)
			{
				varName = "g" + i;
				oldGlare.gotoAndStop(i);
				var oldShape:Shape = oldGlare.getChildAt(0) as Shape;
				this[varName] = new Shape();
				var gData:Vector.<IGraphicsData> = oldShape.graphics.readGraphicsData();
				if (gData[0] is GraphicsBitmapFill)
				{
					var bmpFill:GraphicsBitmapFill = gData[0] as GraphicsBitmapFill;
					var path:GraphicsPath = gData[1] as GraphicsPath;
					this.bmps[this.bmps.length] = new BitmapData(oldShape.width * 4, oldShape.height * 4);
					var newMatrix:Matrix = bmpFill.matrix.clone();
					newMatrix.invert();
					this.bmps[this.bmps.length - 1].draw(oldShape, newMatrix);
					this[varName].graphics.beginBitmapFill(this.bmps[this.bmps.length - 1], bmpFill.matrix, bmpFill.repeat, bmpFill.smooth);
					this[varName].graphics.drawPath(path.commands, path.data, path.winding);
					this[varName].graphics.endFill();
				}
				else
				{
					this[varName].graphics.drawGraphicsData(gData);
				}
			}

			for (i = 13; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
			{
				varName = "g" + i;
				this[varName] = new GemShapesPlusMod[varName]();
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
				throw new ArgumentError("gemshapesplus.shapemodifiers.ReplacementGlare cannot support string frames");
			}
			if (scene != null)
			{
				throw new ArgumentError("gemshapesplus.shapemodifiers.ReplacementGlare doesn't know what a non-null scene means");
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
