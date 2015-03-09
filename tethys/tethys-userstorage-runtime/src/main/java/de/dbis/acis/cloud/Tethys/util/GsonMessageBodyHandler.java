package de.dbis.acis.cloud.Tethys.util;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.lang.annotation.Annotation;
import java.lang.reflect.Type;
 
import javax.ws.rs.Consumes;
import javax.ws.rs.Produces;
import javax.ws.rs.WebApplicationException;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.MultivaluedMap;
import javax.ws.rs.ext.MessageBodyReader;
import javax.ws.rs.ext.MessageBodyWriter;
import javax.ws.rs.ext.Provider;
 
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

/**
 * A MessageBodyHandler to serialize and deserialize Gsons.
 */
@Provider
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public final class GsonMessageBodyHandler implements MessageBodyWriter<Object>, MessageBodyReader<Object> {
 
  private static final String UTF_8 = "UTF-8";
 
  private Gson gson;
 
  /**
   * initializes private Var gson lazyly and returns it.
   * 
   * @return Gson
   */
  private Gson getGson() {
    if (gson == null) {
      final GsonBuilder gsonBuilder = new GsonBuilder().setPrettyPrinting();
      gson = gsonBuilder.create();
    }
    return gson;
  }
 
  /**
   * Ascertain if the MessageBodyReader can produce an instance of a particular type.
   */
  @Override
  public boolean isReadable(Class<?> type, Type genericType, Annotation[] annotations, MediaType mediaType) {
	  return true;
  }
 
  /**
   * Read a type from the InputStream.
   */
  @Override
  public Object readFrom(Class<Object> type, Type genericType, Annotation[] annotations, MediaType mediaType, MultivaluedMap<String, String> httpHeaders, InputStream entityStream) throws IOException {
    InputStreamReader streamReader = new InputStreamReader(entityStream, UTF_8);
    try {
      Type jsonType;
      if (type.equals(genericType)) {
        jsonType = type;
      } else {
        jsonType = genericType;
      }
      return getGson().fromJson(streamReader, jsonType);
    } finally {
      streamReader.close();
    }
  }
 
  /**
   * Ascertain if the MessageBodyWriter supports a particular type.
   */
  @Override
  public boolean isWriteable(Class<?> type, Type genericType, Annotation[] annotations, MediaType mediaType) {
    return true;
  }
 
  /**
   * Called before writeTo to ascertain the length in bytes of the serialized form of object.
   */
  @Override
  public long getSize(Object object, Class<?> type, Type genericType, Annotation[] annotations, MediaType mediaType) {
    return -1;
  }
 
//  @Override
//  public void writeTo(Object object, Class<?> type, Type genericType, Annotation[] annotations, MediaType mediaType, MultivaluedMap<String, Object> httpHeaders, OutputStream entityStream) throws IOException, WebApplicationException {
//    OutputStreamWriter writer = new OutputStreamWriter(entityStream, UTF_8);
//    try {
//      Type jsonType;
//      if (type.equals(genericType)) {
//        jsonType = type;
//      } else {
//        jsonType = genericType;
//      }
//      entityStream.write(getGson().toJson(object).getBytes("UTF-8"));//, jsonType, writer);
//    } finally {
//      writer.close();
//    }
//  }
  
  /**
   * Write a type to an HTTP response.
   */
  @Override
  public void writeTo(Object object, Class<?> type, Type genericType, Annotation[] annotations, MediaType mediaType, MultivaluedMap<String, Object> httpHeaders, OutputStream entityStream) throws IOException, WebApplicationException {
    OutputStreamWriter writer = new OutputStreamWriter(entityStream, UTF_8);
    try {
      Type jsonType;
      if (type.equals(genericType)) {
        jsonType = type;
      } else {
        jsonType = genericType;
      }
      getGson().toJson(object, jsonType, writer);
    } finally {
      writer.close();
    }
  }
  
}