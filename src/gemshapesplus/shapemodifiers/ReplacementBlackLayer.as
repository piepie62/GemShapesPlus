package gemshapesplus.shapemodifiers 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
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

		private var images:Vector.<DisplayObject>;

		public var useOriginals:Boolean = false;
		
		public override function set visible(val:Boolean):void
		{
			super.visible = val;
			this.setVisible(this.shouldBeFrame, val);
		}
		
		public function ReplacementBlackLayer(oldBlackLayer:MovieClip) 
		{
			var scaleX:Number = oldBlackLayer.scaleX, scaleY:Number = oldBlackLayer.scaleY;
			
			this.shouldBeFrame = oldBlackLayer.currentFrame;
			
			this.images = new Vector.<DisplayObject>(GemShapesPlusMod.MAX_EXTRA_GRADE + 1, true);
			this.images[0] = null;

			var i:int;
			
			for (i = 1; i <= 12; i++)
			{
				this.images[i] = new Shape();
				oldBlackLayer.gotoAndStop(i);
				(this.images[i] as Shape).graphics.drawGraphicsData((oldBlackLayer.getChildAt(0) as Shape).graphics.readGraphicsData());
			}

			for (i = 13; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
			{
				this.images[i] = new GemShapesPlusMod["g" + i]();
				
				this.images[i].transform.colorTransform = new ColorTransform(0, 0, 0);
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
			
			for (var grade:int = 1; grade <= GemShapesPlusMod.GRADE_ORDER.length; grade++)
			{
				var image:int = useOriginals ? grade : GemShapesPlusMod.GRADE_ORDER[grade-1];
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
