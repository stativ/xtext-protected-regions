package net.danieldietrich.protectedregions.xtext

import java.io.File
import java.util.Map
import net.danieldietrich.protectedregions.ProtectedRegionSupport
import org.eclipse.xtext.generator.JavaIoFileSystemAccess
import org.eclipse.xtext.generator.OutputConfiguration

class ProtectedRegionJavaIoFileSystemAccess extends JavaIoFileSystemAccess {
	
	val ProtectedRegionSupport protectedRegionSupport
	
	new(ProtectedRegionSupport protectedRegionSupport) {
		super()
		this.protectedRegionSupport = protectedRegionSupport
	}
	
	override postProcess(String fileName, String outputConfiguration, CharSequence content) {
		val postProcessed = super.postProcess(fileName, outputConfiguration, content)
		val file = ""// TODO: fileName / outputConfiguration vs. getURI(fileName, outputConfiguration)
		protectedRegionSupport.merge(file, postProcessed)
	}
	
	override setOutputConfigurations(Map<String, OutputConfiguration> outputs) {
		super.setOutputConfigurations(outputs)
		outputs.values.forEach[protectedRegionSupport.read(new File(it.outputDirectory))]
	}
	
	override setOutputPath(String outputName, String path) {
		super.setOutputPath(outputName, path)
		protectedRegionSupport.read(new File(path))
	}

}
