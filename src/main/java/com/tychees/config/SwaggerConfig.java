package com.tychees.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;
import springfox.documentation.annotations.ApiIgnore;
import springfox.documentation.builders.PathSelectors;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

import java.util.Collections;

/**
 * Swagger Configuration.
 * 
 * @author ryanchee
 * @version 1.0.0
 * @since  1.0.0
 */
@Profile("!prod")
@Configuration
@EnableSwagger2
@RestController
public class SwaggerConfig {

  /**
   * Return Docket as Spring Bean.
   * This will define where/how to apply the Swagger UI.
   * 
   * @return Docket object
   */
  @Bean
  public Docket api() { 
    return new Docket(DocumentationType.SWAGGER_2)
      .select()
      .apis(RequestHandlerSelectors.basePackage("com.tychees.console.controller"))
      .paths(PathSelectors.any())
      .build()
      .apiInfo(apiInfo());
  } // .end of api
  
  /**
   * Return Swagger API definition object.
   * This will appear on top of Swagger UI page.
   * 
   * @return ApiInfo object
   */
  private static ApiInfo apiInfo() {
    return new ApiInfo(
      "Tychees APIs",
      "These APIs serve as Tychees Services",
      "v1.0.0",
      "Terms of service",
       new Contact("Ryan Chee", "www.tychees.com", "ryan.kschee@gmail.com"),
      "Tychees License",
      "API license URL",
       null);
  } // .end of apiInfo
  
  /**
   * Index endpoint ("/") to redirect to swagger-ui.html.
   * If user goto this app route, it will first prompt with swagger UI.
   * 
   * @param attributes RedirectAttributes object
   * @return RedirectView object
   */
//  @ApiIgnore
//  @GetMapping("/")
//  public RedirectView redirectToSwaggerUI(RedirectAttributes attributes) {
//    return new RedirectView("./swagger-ui.html");
//  } // .end redirectToSwaggerUI
}
