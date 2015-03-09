package de.dbis.acis.cloud.Tethys.util;

import com.google.gson.ExclusionStrategy;
import com.google.gson.FieldAttributes;
import com.google.gson.annotations.Expose;

/**
 * To Invert the behaviour of "@Expose" 
 * 
 * @author Gordon Lawrenz <lawrenz@dbis.rwth-aachen.de>
 */
public class GsonExclusionStrategy implements ExclusionStrategy {

	/**
	 * 
	 */
    @Override
    public boolean shouldSkipField(FieldAttributes fieldAttributes) {
        final Expose expose = fieldAttributes.getAnnotation(Expose.class);
        return expose != null && !expose.deserialize();
    }
    
    /**
     * 
     */
    @Override
    public boolean shouldSkipClass(Class<?> aClass) {
        return false;
    }
}
