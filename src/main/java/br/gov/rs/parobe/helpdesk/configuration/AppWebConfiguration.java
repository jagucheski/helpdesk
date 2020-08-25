package br.gov.rs.parobe.helpdesk.configuration;

import java.util.Properties;

import javax.persistence.NoResultException;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.format.datetime.DateFormatter;
import org.springframework.format.datetime.DateFormatterRegistrar;
import org.springframework.format.support.DefaultFormattingConversionService;
import org.springframework.format.support.FormattingConversionService;
import org.springframework.orm.jpa.support.OpenEntityManagerInViewInterceptor;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.support.StandardServletMultipartResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

@EnableWebMvc
@ComponentScan (basePackages = {"br.gov.rs.parobe.helpdesk.controller","br.gov.rs.parobe.helpdesk.dao","br.gov.rs.parobe.helpdesk.model"})
public class AppWebConfiguration extends WebMvcConfigurerAdapter {
	
	@Bean
	public InternalResourceViewResolver internalResourceViewResolver() {
		InternalResourceViewResolver resolver = new InternalResourceViewResolver();
		resolver.setPrefix("/WEB-INF/views/");
		resolver.setSuffix( ".jsp");
		
//		resolver.setExposeContextBeansAsAttributes(true);
//		resolver.setExposedContextBeanNames("carrinhoCompras");
		
		return resolver;
	}

	@Bean
	public MessageSource messageSource(){
		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasename("/WEB-INF/messages");
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setCacheSeconds(1);
		return messageSource;
	}
	
	@Bean
	public FormattingConversionService mvcConversionService() {
		DefaultFormattingConversionService conversionService = new DefaultFormattingConversionService();
		DateFormatterRegistrar registrar = new DateFormatterRegistrar();
		registrar.setFormatter(new DateFormatter("dd/MM/yyyy"));
		registrar.registerFormatters(conversionService);		
		return conversionService;
	}
	
    @Bean
	public MultipartResolver multipartResolver(){
		return new StandardServletMultipartResolver();
	}
    
	@Bean
	public RestTemplate restTemplate(){
		return new RestTemplate();
	}
    
    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }
    
	@Bean
	public OpenEntityManagerInViewInterceptor getOpenEntityManagerInViewInterceptor() {
		return new OpenEntityManagerInViewInterceptor();
	}	
	
	@Bean
	public LocalValidatorFactoryBean getValidator() {
	    LocalValidatorFactoryBean bean = new LocalValidatorFactoryBean();
	    bean.setValidationMessageSource(messageSource());
	    return bean;
	}
	
	@Bean(name="simpleMappingExceptionResolver")
	public SimpleMappingExceptionResolver createSimpleMappingExceptionResolver() {
	   SimpleMappingExceptionResolver simpleMappingExceptionResolver = new SimpleMappingExceptionResolver();

	   Properties mappings = new Properties();
	   mappings.setProperty("InvalidRequestException", "erros/404");
	   mappings.setProperty(NotFoundException.class.getName(), "erros/404");
	   mappings.setProperty("GenericServerException", "erros/500");
	   mappings.setProperty("IllegalArgumentException", "erros/500");
	   mappings.setProperty(NoResultException.class.getName(), "erros/500");
	   mappings.setProperty(NullPointerException.class.getName(), "erros/500");
	   mappings.setProperty(Exception.class.getName(), "erros/500");

	   simpleMappingExceptionResolver.setExceptionMappings(mappings); 
	   simpleMappingExceptionResolver.setDefaultErrorView("erros/500");
	   simpleMappingExceptionResolver.setExceptionAttribute("ex");
	   simpleMappingExceptionResolver.setWarnLogCategory("org.springframework.web.servlet.handler.SimpleMappingExceptionResolver");
	   
	   return simpleMappingExceptionResolver;
	 }
   
}
	