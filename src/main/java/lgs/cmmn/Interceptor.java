package lgs.cmmn;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Interceptor extends HandlerInterceptorAdapter{

	protected final Logger logger = LoggerFactory.getLogger(Interceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
			try {
				HttpSession session = request.getSession();
				String userId = session.getAttribute("id").toString();

				if (userId != null && userId != "" && userId != "undefined") {
					return true;
				} else {
					ModelAndView modelAndView = new ModelAndView("redirect:/admin");
					throw new ModelAndViewDefiningException(modelAndView);
				}
			} catch (Exception e) {
				ModelAndView modelAndView = new ModelAndView("redirect:/admin");
				throw new ModelAndViewDefiningException(modelAndView);
			}
	}
}
