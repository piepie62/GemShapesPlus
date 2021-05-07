package gemshapesplus.shapemodifiers 
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import gemshapesplus.GemShapesPlusMod;
	/**
	 * ...
	 * @author Chris
	 */
	public class ReplacementGlare extends MovieClip
	{
		private var oldGlare:MovieClip;
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
		
		public override function set visible(val:Boolean):void
		{
			super.visible = val;
			this.setVisible(this.shouldBeFrame, val);
		}
		
		public function ReplacementGlare(oldGlare:MovieClip) 
		{
			this.oldGlare = oldGlare;
			
			this.shouldBeFrame = this.oldGlare.currentFrame;
			
			var i:int;
			var varName:String;

			for (i = 13; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
			{
				varName = "g" + i;
				this[varName] = new GemShapesPlusMod[varName]();
				
				this[varName].scaleX = this[varName].scaleY = 1.8;
				
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
				oldGlare.gotoAndStop(frame);
				oldGlare.visible = val;
				for (i = 13; i <= GemShapesPlusMod.MAX_EXTRA_GRADE; i++)
				{
					this["g" + i].visible = false;
				}
			}
			else
			{
				oldGlare.visible = false;
				
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
