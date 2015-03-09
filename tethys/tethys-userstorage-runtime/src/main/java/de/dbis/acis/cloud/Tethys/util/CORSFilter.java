package de.dbis.acis.cloud.Tethys.util;

import java.io.IOException;

import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import javax.ws.rs.ext.Provider;

@Provider
public class CORSFilter implements ContainerResponseFilter {
	

    public static String VALID_METHODS = "DELETE, HEAD, GET, OPTIONS, POST, PUT";

//    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws ServletException, IOException {
////        HttpServletRequest httpReq = (HttpServletRequest) req;
//        HttpServletResponse httpResp = (HttpServletResponse) resp;
//
////        // No Origin header present means this is not a cross-domain request
////        String origin = httpReq.getHeader("Origin");
////         if (origin == null) {
////            // Return standard response if OPTIONS request w/o Origin header
////           if ("OPTIONS".equalsIgnoreCase(httpReq.getMethod())) {
////                httpResp.setHeader("Allow", VALID_METHODS);
////                httpResp.setStatus(200);
////                return;
////            }
////        } else {
////            // This is a cross-domain request, add headers allowing access
////            httpResp.setHeader("Access-Control-Allow-Origin", origin);
////            httpResp.setHeader("Access-Control-Allow-Methods", VALID_METHODS);
////
////            String headers = httpReq.getHeader("Access-Control-Request-Headers");
////            if (headers != null)
//////                httpResp.setHeader("Access-Control-Allow-Headers", headers);
////            	httpResp.setHeader("Access-Control-Allow-Headers", "Accept, Content-Type, Origin, X-Auth-Token");
////            // Allow caching cross-domain permission
////            httpResp.setHeader("Access-Control-Max-Age", "3600");
////        }
////        // Pass request down the chain, except for OPTIONS
////        if (!"OPTIONS".equalsIgnoreCase(httpReq.getMethod())) {
////            chain.doFilter(req, resp);
////        }
// }

    @Override
	public void filter(ContainerRequestContext requestContext, ContainerResponseContext responseContext) throws IOException {
		responseContext.getHeaders().add("Access-Control-Allow-Origin", "*");
		responseContext.getHeaders().add("Access-Control-Allow-Methods",VALID_METHODS);
		responseContext.getHeaders().add("Access-Control-Allow-Headers","Accept, Content-Type, Origin, X-Auth-Token");
		
	}
	
}