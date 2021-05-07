package gemshapesplus 
{
	import Bezel.Bezel;
	import Bezel.GCFW.GCFWBezel;
	import Bezel.Lattice.Lattice;
	/**
	 * ...
	 * @author Chris
	 */
	public class GemShapesPlusCoreMod 
	{
		internal static const VERSION:String = "2";
		internal static function installCoremods(lattice:Lattice):void
		{
			if (lattice.doesFileExist("com/giab/games/gcfw/Main.class.asasm"))
			{
				GemShapesPlusMod.logger.log("installCoremods", "Found GCFW, installing coremod");
				installGemCoremod(lattice, "gcfw");
				installVfxCoremod(lattice, "gcfw");
			}
			else
			{
				GemShapesPlusMod.logger.log("installCoremods", "Found GCCS, installing coremod");
				installGemCoremod(lattice, "gccs/steam");
				installVfxCoremod(lattice, "gccs/steam");
			}
		}
		
		private static function installGemCoremod(lattice:Lattice, baseGame:String):void
		{
			var filename:String = "com/giab/games/" + baseGame + "/mcDyn/McGem.class.asasm";
			var offset:int = lattice.findPattern(filename, /refid.*McGem\/instance\/init/);
			if (offset == -1)
			{
				GemShapesPlusMod.logger.log("installGemCoremod", "Could not find proper place to apply gem coremod!");
				return;
			}
			
			offset = lattice.findPattern(filename, /maxstack/, offset);
			if (offset == -1)
			{
				GemShapesPlusMod.logger.log("installGemCoremod", "Could not find proper place to apply gem coremod!");
				return;
			}
			lattice.patchFile(filename, offset - 1, 1, "maxstack 10");
			
			offset = lattice.findPattern(filename, /returnvoid/, offset);
			if (offset == -1)
			{
				GemShapesPlusMod.logger.log("installGemCoremod", "Could not find proper place to apply gem coremod!");
				return;
			}
			
			lattice.patchFile(filename, offset-1, 0, ' \
				getlex QName(PackageNamespace("com.giab.games.' + baseGame.replace(/\//g, '.') + '"), "GV") \n \
				getproperty QName(PackageNamespace(""), "main") \n \
				getproperty QName(PackageNamespace(""), "bezel") \n \
				pushstring "Gem Shapes Plus" \n \
				callproperty QName(PackageNamespace(""), "getModByName"), 1 \n \
				getproperty QName(PackageNamespace(""), "loaderInfo") \n \
				getproperty QName(PackageNamespace(""), "applicationDomain") \n \
				pushstring "gemshapesplus.' + baseGame.replace(/\//g, '.') + '.ShapeAdder" \n \
				callproperty QName(PackageNamespace(""), "getDefinition"), 1 \n \
				getlocal0 \n \
				callpropvoid QName(PackageNamespace(""), "addShapes"), 1');
		}
		
		private static function installVfxCoremod(lattice:Lattice, baseGame:String):void
		{
			var filename:String = "com/giab/games/" + baseGame + "/mcVfx/McVfxTowerShotGlare.class.asasm";
			var offset:int = lattice.findPattern(filename, /refid.*McVfxTowerShotGlare\/instance\/init/);
			if (offset == -1)
			{
				GemShapesPlusMod.logger.log("installGemCoremod", "Could not find proper place to apply gem coremod!");
				return;
			}
			
			offset = lattice.findPattern(filename, /maxstack/, offset);
			if (offset == -1)
			{
				GemShapesPlusMod.logger.log("installGemCoremod", "Could not find proper place to apply gem coremod!");
				return;
			}
			lattice.patchFile(filename, offset - 1, 1, "maxstack 10");
			
			offset = lattice.findPattern(filename, /returnvoid/, offset);
			if (offset == -1)
			{
				GemShapesPlusMod.logger.log("installGemCoremod", "Could not find proper place to apply gem coremod!");
				return;
			}
			
			lattice.patchFile(filename, offset-1, 0, ' \
				getlex QName(PackageNamespace("com.giab.games.' + baseGame.replace(/\//g, '.') + '"), "GV") \n \
				getproperty QName(PackageNamespace(""), "main") \n \
				getproperty QName(PackageNamespace(""), "bezel") \n \
				pushstring "Gem Shapes Plus" \n \
				callproperty QName(PackageNamespace(""), "getModByName"), 1 \n \
				getproperty QName(PackageNamespace(""), "loaderInfo") \n \
				getproperty QName(PackageNamespace(""), "applicationDomain") \n \
				pushstring "gemshapesplus.' + baseGame.replace(/\//g, '.') + '.ShapeAdder" \n \
				callproperty QName(PackageNamespace(""), "getDefinition"), 1 \n \
				getlocal0 \n \
				callpropvoid QName(PackageNamespace(""), "addVfxShapes"), 1');
		}
	}

}