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
	import flash.geom.Point;
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

		private var images:Vector.<DisplayObject>;
		
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
			
			this.images = new Vector.<DisplayObject>(GemShapesPlusMod.MAX_EXTRA_GRADE + 1, true);
			this.images[0] = null;
			
			var i:int;
			
			for (i = 1; i <= 12; i++)
			{
				oldGlare.gotoAndStop(i);
				var oldShape:Shape = oldGlare.getChildAt(0) as Shape;
				this.images[i] = new Shape();
				var gData:Vector.<IGraphicsData> = oldShape.graphics.readGraphicsData();
				if (gData[0] is GraphicsBitmapFill)
				{
					var bmpFill:GraphicsBitmapFill = gData[0] as GraphicsBitmapFill;
					var path:GraphicsPath = gData[1] as GraphicsPath;
					this.bmps[this.bmps.length] = new BitmapData(oldShape.width * bmpFill.matrix.transformPoint(new Point(1, 0)).length, oldShape.height * bmpFill.matrix.transformPoint(new Point(0, 1)).length);
					var newMatrix:Matrix = bmpFill.matrix.clone();
					newMatrix.invert();
					this.bmps[this.bmps.length - 1].draw(oldShape, newMatrix);
					(this.images[i] as Shape).graphics.beginBitmapFill(this.bmps[this.bmps.length - 1], bmpFill.matrix, bmpFill.repeat, bmpFill.smooth);
					(this.images[i] as Shape).graphics.drawPath(path.commands, path.data, path.winding);
					(this.images[i] as Shape).graphics.endFill();
				}
				else
				{
					(this.images[i] as Shape).graphics.drawGraphicsData(gData);
				}
			}

			for (i = 13; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
			{
				this.images[i] = new GemShapesPlusMod["g" + i]();
			}
			
			var width:Number = Number.MIN_VALUE, height:Number = Number.MIN_VALUE;
			
			for (i = 1; i < GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
			{
				width = Math.max(this.images[i].width, width);
				height = Math.max(this.images[i].height, height);
			}
			
			var rect:Rectangle;
			
			for (i = 1; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
			{
				rect = this.images[i].getRect(this.images[i]);
				this.addChild(this.images[i]);
				this.images[i].x = (width - this.images[i].width) / 2 - rect.x;
				this.images[i].y = (height - this.images[i].height) / 2 - rect.y;
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
			
			for (var grade:int = 1; grade <= GemShapesPlusMod.GRADE_ORDER.length; grade++)
			{
				var image:int = GemShapesPlusMod.GRADE_ORDER[grade-1];
				if (grade == activeSprite)
				{
					this.images[image].visible = val;
				}
				else
				{
					this.images[image].visible = false;
				}
			}
		}
		
	}

}
