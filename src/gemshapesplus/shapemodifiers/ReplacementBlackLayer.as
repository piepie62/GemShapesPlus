package gemshapesplus.shapemodifiers 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.ColorTransform;
	import gemshapesplus.GemShapesPlusMod;
	/**
	 * ...
	 * @author Chris
	 */
	public class ReplacementBlackLayer extends MovieClip
	{
		private var oldBlackLayer:MovieClip;
		private var shouldBeFrame:int;
		
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
		
		public override function set mask(val:DisplayObject):void
		{
			super.mask = val;
			this.oldBlackLayer.mask = val;
		}
		
		public function ReplacementBlackLayer(oldBlackLayer:MovieClip) 
		{
			this.oldBlackLayer = oldBlackLayer;
			
			this.shouldBeFrame = this.oldBlackLayer.currentFrame;
			
			var i:int;
			var varName:String;

			for (i = 13; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
			{
				varName = "g" + i;
				this[varName] = new GemShapesPlusMod[varName]();
				
				this[varName].scaleX = this.oldBlackLayer.scaleX;
				this[varName].scaleY = this.oldBlackLayer.scaleY;
				this[varName].transform.colorTransform = new ColorTransform(0, 0, 0);
				
				this.addChild(this[varName]);
			}
			
			for (i = 13; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
			{
				varName = "g" + i;
				this[varName].x = (this.width - this[varName].width) / 2;
				this[varName].y = (this.height - this[varName].height) / 2;
			}
			
			this.setVisible(this.shouldBeFrame, this.visible);
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
			var i:int;
			if (frame <= 12)
			{
				oldBlackLayer.gotoAndStop(frame);
				oldBlackLayer.visible = val;
				
				for (i = 13; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
				{
					this["g" + i].visible = false;
				}
			}
			else
			{
				oldBlackLayer.visible = false;
				
				var activeSprite:int = Math.min(GemShapesPlusMod.MAX_EXTRA_GRADE, frame);
				
				for (i = 13; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
				{
					if (i == activeSprite)
					{
						this["g" + i].visible = val;
					}
					else
					{
						this["g" + i].visible = false;
					}
				}
			}
		}
		
	}

}
