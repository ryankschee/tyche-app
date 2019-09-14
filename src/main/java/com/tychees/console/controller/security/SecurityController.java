package com.tychees.console.controller.security;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import com.tychees.core.bean.inventory.InventoryCategoryBean;
import com.tychees.core.bean.place.PlaceAccessBean;
import com.tychees.core.bean.place.PlaceAccessPropertiesBean;
import com.tychees.core.bean.place.PlaceBean;
import com.tychees.core.bean.place.PlaceDocumentBean;
import com.tychees.core.bean.place.PlaceModuleBean;
import com.tychees.core.bean.place.PlaceRoleBean;
import com.tychees.core.bean.place.PlaceSettingsBean;
import com.tychees.core.bean.place.PlaceWorkflowBean;
import com.tychees.core.bean.place.PlaceWorkflowEventBean;
import com.tychees.core.bean.user.UserBean;
import com.tychees.core.bean.user.UserSecurityBean;
import com.tychees.core.bean.user.UserSessionBean;
import com.tychees.core.constants.AppConstants;
import com.tychees.core.constants.InventoryConstants;
import com.tychees.core.constants.ModuleConstants;
import com.tychees.core.constants.PlaceConstants;
import com.tychees.core.constants.SettingsConstants;
import com.tychees.core.controller.AbstractController;
import com.tychees.core.controller.RequestStatus;
import com.tychees.core.mail.MailGunUtil;
import com.tychees.console.controller.security.request.AuthenticateRequestBody;
import com.tychees.console.controller.security.request.LoginRequestBody;
import com.tychees.console.controller.security.request.LogoutRequestBody;
import com.tychees.console.controller.security.request.PreLoginRequestBody;
import com.tychees.console.controller.security.request.RegisterPlaceRequestBody;
import com.tychees.console.controller.security.request.RegisterUserRequestBody;
import com.tychees.console.controller.security.request.ResetUserPasswordRequestBody;
import com.tychees.console.controller.security.request.ValidatePlaceRegistrationRequestBody;
import com.tychees.console.controller.security.request.ValidateUserEmailRequestBody;
import com.tychees.console.controller.security.request.ValidateUserRegistrationRequestBody;
import com.tychees.console.controller.security.response.AuthenticateResponseBody;
import com.tychees.console.controller.security.response.LoginResponseBody;
import com.tychees.console.controller.security.response.LogoutResponseBody;
import com.tychees.console.controller.security.response.PreLoginResponseBody;
import com.tychees.console.controller.security.response.RegisterPlaceResponseBody;
import com.tychees.console.controller.security.response.RegisterUserResponseBody;
import com.tychees.console.controller.security.response.ResetUserPasswordResponseBody;
import com.tychees.console.controller.security.response.ValidatePlaceRegistrationResponseBody;
import com.tychees.console.controller.security.response.ValidateUserEmailResponseBody;
import com.tychees.console.controller.security.response.ValidateUserRegistrationResponseBody;
import com.tychees.core.service.BillingService;
import com.tychees.core.service.FormatterService;
import com.tychees.core.service.InventoryService;
import com.tychees.core.service.PlaceService;
import com.tychees.core.service.UserService;
import com.tychees.core.util.SecurityUtil;

@RestController
public class SecurityController
  extends AbstractController
{
  @Autowired
  ModuleConstants moduleConstants;
  @Autowired
  InventoryConstants inventoryConstants;
  @Autowired
  SettingsConstants settingsConstants;
  @Autowired
  PlaceConstants placeConstants;
  @Autowired
  BillingService billingService;
  @Autowired
  PlaceService placeService;
  @Autowired
  UserService userService;
  @Autowired
  InventoryService inventoryService;
  @Autowired
  SecurityUtil securityUtil;
  @Autowired
  MailGunUtil mailGunUtil;

  public final static int HASH_ITERATION_COUNT = 1000;

  //private static final Logger LOGGER = Logger.getLogger(SecurityController.class.getName());

  //--------------------------------------------------------------------------

  @GetMapping(value = "/console/test")
  public String test() {
    return "Test Success";
  }

  @RequestMapping(value = "/console/preloginTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public PreLoginResponseBody preloginHandlerTest(HttpServletRequest request, @RequestBody PreLoginRequestBody requestBody)
  {
    return preloginHandler(request, requestBody);
  } // .end of preloginHandlerTest

  //@CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL,  methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"})
  @RequestMapping(value = "/console/prelogin", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public PreLoginResponseBody preloginHandler(HttpServletRequest request, @RequestBody PreLoginRequestBody requestBody)
  {
    // TASKS: Pre
    long startTime = Calendar.getInstance().getTimeInMillis();

    // Prepare response object
    PreLoginResponseBody responseBody = new PreLoginResponseBody();
    responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;

    UserBean userObj = userService.getUserByEmail(requestBody.email, false);
    if (userObj == null) {
      responseBody.salt = securityUtil.generateSalt(32);
    } else {
      String cSalt = userService.getCSalt(userObj.getId());
      if (cSalt == null)
        cSalt = securityUtil.generateSalt(32);

      responseBody.salt = cSalt;
    }

    long endTime = Calendar.getInstance().getTimeInMillis();
    responseBody.elapsedTimeInMillis = endTime - startTime;

    return responseBody;
  } // .end of preloginHandler
  //--------------------------------------------------------------------------

  @RequestMapping(value = "/console/authenticateTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public AuthenticateResponseBody authenticateHandlerTest(HttpServletRequest request, @RequestBody AuthenticateRequestBody requestBody)
  {
    return authenticateHandler(request, requestBody);
  } // .end of authenticateHandlerTest

  @CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL,  methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"})
  @RequestMapping(value = "/console/authenticate", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public AuthenticateResponseBody authenticateHandler(HttpServletRequest request, @RequestBody AuthenticateRequestBody requestBody)
  {
    // TASKS: Pre
    long startTime = Calendar.getInstance().getTimeInMillis();

    // Prepare response object
    AuthenticateResponseBody responseBody = new AuthenticateResponseBody();
    responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;

    UserBean userObj = userService.getUserByEmail(requestBody.email, false);
    if (userObj == null) {
      responseBody.status = RequestStatus.AUTHENTICATION_FAILURE;
    } else {
      String sSalt = userService.getSSalt(userObj.getId());
      String hashedPwd = securityUtil.generateSecurePassword(requestBody.password, sSalt.getBytes());

      // TASK #1: Get User Object
      UserBean currentUserObj = userService.authenticate(requestBody.email, hashedPwd);

      if (currentUserObj==null)
      {
        responseBody.status = RequestStatus.AUTHENTICATION_FAILURE;
      }
      else
      {
        UserSessionBean sessionObj = getActiveSession( currentUserObj );
        if (sessionObj != null)
        {
          // Set values into response body
          responseBody.status = RequestStatus.REQUEST_SUCCESS;
          responseBody.userId = currentUserObj.getId();
          responseBody.sessionId = sessionObj.getId();
          responseBody.currentUserObj = currentUserObj;
          responseBody.currentSessionObj = sessionObj;
        }
        else
        {
          responseBody.status = RequestStatus.AUTHENTICATION_FAILURE;
        }
      }
    }

    long endTime = Calendar.getInstance().getTimeInMillis();
    responseBody.elapsedTimeInMillis = endTime - startTime;

    return responseBody;
  } // .end of authenticateHandler

  //--------------------------------------------------------------------------

  @RequestMapping(value = "/console/loginTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public LoginResponseBody loginHandlerTest(HttpServletRequest request, @RequestBody LoginRequestBody requestBody)
  {
    return loginHandler(request, requestBody);
  } // .end of loginHandlerTest

  @CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL,  methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"})
  @RequestMapping(value = "/console/login", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public LoginResponseBody loginHandler(HttpServletRequest request, @RequestBody LoginRequestBody requestBody)
  {
    // TASKS: Pre
    long startTime = Calendar.getInstance().getTimeInMillis();

    // Prepare response object
    LoginResponseBody responseBody = new LoginResponseBody();
    responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;

    UserBean userObj = userService.getUserByEmail(requestBody.email, false);
    if (userObj == null) {
      responseBody.status = RequestStatus.AUTHENTICATION_FAILURE;
    } else {
      String sSalt = userService.getSSalt(userObj.getId());
      String hashedPwd = securityUtil.generateSecurePassword(requestBody.password, sSalt.getBytes());

      // TASK #1: Get User Object
      UserBean currentUserObj = userService.authenticate(requestBody.email, hashedPwd);

      if (currentUserObj==null)
      {
        responseBody.status = RequestStatus.AUTHENTICATION_FAILURE;
      }
      else
      {
        UserSessionBean sessionObj = getActiveSession( currentUserObj );
        if (sessionObj != null)
        {
          sessionObj.setLastAccessedOn( new Timestamp(Calendar.getInstance().getTimeInMillis()) );
          sessionObj.setReadableLastAccessedOn( FormatterService.DATE_FORMAT_FULL.format(sessionObj.getLastAccessedOn()) );
          userService.saveOrUpdateUser( currentUserObj, currentUserObj.getId() );
        }
        else
        {
          sessionObj = getNewSession( request, requestBody, currentUserObj );
          currentUserObj.sessionList.add( sessionObj );
          currentUserObj.setLogoutRequired(false);
          userService.saveOrUpdateUser( currentUserObj, currentUserObj.getId() );
        }

        // Set values into response body
        responseBody.status = RequestStatus.REQUEST_SUCCESS;
        responseBody.userId = currentUserObj.getId();
        responseBody.sessionId = sessionObj.getId();
        responseBody.rememberMe = requestBody.rememberMe;
        responseBody.currentUserObj = currentUserObj;
        responseBody.currentSessionObj = sessionObj;
        responseBody.placeList = placeService.getPlacesByUserId( currentUserObj.getId(), false );
      }
    }

    long endTime = Calendar.getInstance().getTimeInMillis();
    responseBody.elapsedTimeInMillis = endTime - startTime;

    return responseBody;
  } // .end of loginHandler

  //--------------------------------------------------------------------------

  @RequestMapping(value = "/console/logoutTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public LogoutResponseBody logoutHandlerTest(HttpServletRequest request, @RequestBody LogoutRequestBody requestBody)
  {
    return logoutHandler(request, requestBody);
  } // .end of logoutHandlerTest

  @CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL,  methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"})
  @RequestMapping(value = "/console/logout", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public LogoutResponseBody logoutHandler(HttpServletRequest request, @RequestBody LogoutRequestBody requestBody)
  {
    // TASKS: Pre
    long startTime = Calendar.getInstance().getTimeInMillis();

    // Prepare response object
    LogoutResponseBody responseBody = new LogoutResponseBody();
    responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;

    if (requestBody.sessionId == null || "".equals(requestBody.sessionId.trim())) {

    } else {

      // Get User object
      UserBean userObj = userService.getUserBySessionId(requestBody.sessionId, true);
      if (userObj != null) {
        for (UserSessionBean sessionObj : userObj.sessionList)
        {
          if (sessionObj.getId().equals(requestBody.sessionId))
          {
            sessionObj.setActive( false );
            sessionObj.setEndedOn( new Timestamp(Calendar.getInstance().getTimeInMillis()) );
            sessionObj.setReadableLastAccessedOn( FormatterService.DATE_FORMAT_FULL.format(sessionObj.getEndedOn()) );
          }
        }

        // Save user's session
        userService.saveOrUpdateUser( userObj, userObj.getId() );
      }

      // Invalidate HTTP session
      HttpSession session = request.getSession(true);
      if (session != null)
        session.invalidate();
    }

    responseBody.status = RequestStatus.REQUEST_SUCCESS;

    long endTime = Calendar.getInstance().getTimeInMillis();
    responseBody.elapsedTimeInMillis = endTime - startTime;

    return responseBody;
  } // .end of logoutHandler

  //--------------------------------------------------------------------------

  @RequestMapping(value = "/console/resetUserPasswordTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public ResetUserPasswordResponseBody resetUserPasswordHandlerTest(HttpServletRequest request, @RequestBody ResetUserPasswordRequestBody requestBody)
  {
    return resetUserPasswordHandler(request, requestBody);
  } // .end of resetUserPasswordHandlerTest

  @CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL,  methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"})
  @RequestMapping(value = "/console/resetUserPassword", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public ResetUserPasswordResponseBody resetUserPasswordHandler(HttpServletRequest request, @RequestBody ResetUserPasswordRequestBody requestBody)
  {
    // TASKS: Pre
    long startTime = Calendar.getInstance().getTimeInMillis();

    // TASK #1: Prepare response object
    ResetUserPasswordResponseBody responseBody = new ResetUserPasswordResponseBody();
    responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;

    UserBean userObj = userService.getUserById(requestBody.userId, false);
    UserSecurityBean userSecurityObj = userService.getUserSecurityById(requestBody.userId);
    if (userSecurityObj == null) {
      userSecurityObj = new UserSecurityBean();
      userSecurityObj.setId(userObj.getId());
      userSecurityObj.setCreatedBy(userObj.getId());
      userSecurityObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
    }

    // Generate Server Salt
    String sSalt = securityUtil.generateSalt(32);

    // User Security Bean
    userSecurityObj.setPassword(securityUtil.generateSecurePassword(requestBody.password, sSalt.getBytes()));
    userSecurityObj.setCSalt(requestBody.salt);
    userSecurityObj.setSSalt(sSalt);

    // Update User
    userObj.setResetPasswordRequired(requestBody.resetPasswordRequired);

    // Save to DB
    userService.saveOrUpdateUser(userObj, userObj.getId());
    userService.saveOrUpdateUserSecurity(userSecurityObj, userObj.getId());

    // Send email
    //mailGunUtil.SendSimpleMessage();

    // Finishing responseObj
    long endTime = Calendar.getInstance().getTimeInMillis();
    responseBody.elapsedTimeInMillis = endTime - startTime;
    responseBody.userEmail = userObj.getEmail();
    responseBody.status = RequestStatus.REQUEST_SUCCESS;

    return responseBody;
  } // .end of resetUserPasswordHandler

  //--------------------------------------------------------------------------

  @RequestMapping(value = "/console/validateUserEmailTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public ValidateUserEmailResponseBody validateUserEmailHandlerTest(HttpServletRequest request, @RequestBody ValidateUserEmailRequestBody requestBody)
  {
    return validateUserEmailHandler(request, requestBody);
  } // .end of validateUserEmailHandlerTest

  @CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL,  methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"})
  @RequestMapping(value = "/console/validateUserEmail", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public ValidateUserEmailResponseBody validateUserEmailHandler(HttpServletRequest request, @RequestBody ValidateUserEmailRequestBody requestBody)
  {
    // TASKS: Pre
    long startTime = Calendar.getInstance().getTimeInMillis();

    // TASK #1: Prepare response object
    ValidateUserEmailResponseBody responseBody = new ValidateUserEmailResponseBody();
    responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;

    UserBean userObj = userService.getUserByEmail(requestBody.email, false);
    if (userObj != null)
      responseBody.emailExists = true;

    // Finishing responseObj
    long endTime = Calendar.getInstance().getTimeInMillis();
    responseBody.elapsedTimeInMillis = endTime - startTime;
    responseBody.status = RequestStatus.REQUEST_SUCCESS;

    return responseBody;
  } // .end of validateUserEmailHandler

  //--------------------------------------------------------------------------

  @RequestMapping(value = "/console/validateUserRegistrationTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public ValidateUserRegistrationResponseBody validateUserRegistrationHandlerTest(HttpServletRequest request, @RequestBody ValidateUserRegistrationRequestBody requestBody)
  {
    return validateUserRegistrationHandler(request, requestBody);
  } // .end of validateUserRegistrationHandlerTest

  @CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL,  methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"})
  @RequestMapping(value = "/console/validateUserRegistration", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public ValidateUserRegistrationResponseBody validateUserRegistrationHandler(HttpServletRequest request, @RequestBody ValidateUserRegistrationRequestBody requestBody)
  {
    // TASKS: Pre
    long startTime = Calendar.getInstance().getTimeInMillis();

    // TASK #1: Prepare response object
    ValidateUserRegistrationResponseBody responseBody = new ValidateUserRegistrationResponseBody();
    responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;

    UserBean userObj = userService.getUserByEmail(requestBody.email, false);
    if (userObj != null)
      responseBody.emailExists = true;

    PlaceBean placeObj = placeService.getPlaceById(requestBody.companyUid, false);
    if (placeObj != null)
      responseBody.companyUidExists = true;

    // Finishing responseObj
    long endTime = Calendar.getInstance().getTimeInMillis();
    responseBody.elapsedTimeInMillis = endTime - startTime;
    responseBody.status = RequestStatus.REQUEST_SUCCESS;

    return responseBody;
  } // .end of validateUserRegistrationHandler

  //--------------------------------------------------------------------------

  @RequestMapping(value = "/console/registerUserTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public RegisterUserResponseBody registerUserHandlerTest(HttpServletRequest request, @RequestBody RegisterUserRequestBody requestBody)
  {
    return registerUserHandlerTest(request, requestBody);
  } // .end of registerUserHandlerTest

  @CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL,  methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"})
  @RequestMapping(value = "/console/registerUser", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public RegisterUserResponseBody registerUserHandler(HttpServletRequest request, @RequestBody RegisterUserRequestBody requestBody)
  {
    // TASKS: Pre
    long startTime = Calendar.getInstance().getTimeInMillis();

    // TASK #1: Prepare response object
    RegisterUserResponseBody responseBody = new RegisterUserResponseBody();
    responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;

    // (1) REGISTRATION
    //     - place_table (company name, placeId)
    //       - place_access_table
    //         - place_access_properties_table
    //       - place_role_table
    //       - place_settings_table
    //       - place_module_table
    //       - place_workflow
    //     - user_table (email, first name, last name, password)
    //       //- user_access_right_table
    //     - inventory_category_table

    // User Object
    UserBean userObj = new UserBean();
    userObj.setFirstName(requestBody.firstName);
    userObj.setLastName(requestBody.lastName);
    userObj.setEmail(requestBody.email);
    userObj.setCreatedBy(userObj.getId());
    userObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

    // Place Object
    PlaceBean placeObj = new PlaceBean();
    placeObj.setId(requestBody.companyUid);
    placeObj.setName(requestBody.companyName);
    placeObj.setCompanyName(requestBody.companyName);
    placeObj.setCategory("Local Business");
    placeObj.setSubcategory(requestBody.businessType);
    placeObj.setCreatedBy(userObj.getId());
    placeObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

    // UserAccessRightBean / PlaceAccessBean / PlaceRoleBean
    setupAccess(placeObj, userObj, requestBody.businessType);

    // PlaceModuleBean
    setupPlaceModule(placeObj, userObj, requestBody.businessType);

    // PlaceSettingsBean
    setupPlaceSettings(placeObj, userObj, requestBody.businessType);

    // PlaceWorkflowBean
    setupPlaceWorkflow(placeObj, userObj, requestBody.businessType);

    // PlaceDocumentBean
    setupPlaceDocument(placeObj, userObj, requestBody.businessType);

    // Inventory
    List<InventoryCategoryBean> categoryList = setupInventory(placeObj, userObj);

    // Generate Salt at Server side
    String sSalt = securityUtil.generateSalt(32);

    // User Security Bean
    UserSecurityBean userSecurityObj = new UserSecurityBean();
    userSecurityObj.setId(userObj.getId());
    userSecurityObj.setPassword(securityUtil.generateSecurePassword(requestBody.password, sSalt.getBytes()));
    userSecurityObj.setCSalt(requestBody.salt);
    userSecurityObj.setSSalt(sSalt);
    userSecurityObj.setCreatedBy(userObj.getId());
    userSecurityObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

    // Save to DB
    userService.saveOrUpdateUser(userObj, userObj.getId());
    userService.saveOrUpdateUserSecurity(userSecurityObj, userObj.getId());
    placeService.saveOrUpdatePlace(placeObj, userObj.getId());
    for (InventoryCategoryBean categoryObj : categoryList) {
      inventoryService.saveOrUpdateCategory(categoryObj, userObj.getId());
    }

    // Finishing responseObj
    long endTime = Calendar.getInstance().getTimeInMillis();
    responseBody.elapsedTimeInMillis = endTime - startTime;
    responseBody.status = RequestStatus.REQUEST_SUCCESS;

    return responseBody;
  } // .end of registerUserHandler

  //--------------------------------------------------------------------------

  @RequestMapping(value = "/console/validatePlaceRegistrationTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public ValidatePlaceRegistrationResponseBody validatePlaceRegistrationHandlerTest(HttpServletRequest request, @RequestBody ValidatePlaceRegistrationRequestBody requestBody)
  {
    return validatePlaceRegistrationHandler(request, requestBody);
  } // .end of validatePlaceRegistrationHandlerTest

  @CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL,  methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"})
  @RequestMapping(value = "/console/validatePlaceRegistration", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public ValidatePlaceRegistrationResponseBody validatePlaceRegistrationHandler(HttpServletRequest request, @RequestBody ValidatePlaceRegistrationRequestBody requestBody)
  {
    // TASKS: Pre
    long startTime = Calendar.getInstance().getTimeInMillis();

    // TASK #1: Prepare response object
    ValidatePlaceRegistrationResponseBody responseBody = new ValidatePlaceRegistrationResponseBody();
    responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;

    PlaceBean placeObj = placeService.getPlaceById(requestBody.companyUid, false);
    if (placeObj != null)
      responseBody.companyUidExists = true;

    // Finishing responseObj
    long endTime = Calendar.getInstance().getTimeInMillis();
    responseBody.elapsedTimeInMillis = endTime - startTime;
    responseBody.status = RequestStatus.REQUEST_SUCCESS;

    return responseBody;
  } // .end of validatePlaceRegistrationHandler

  //--------------------------------------------------------------------------

  @RequestMapping(value = "/console/registerPlaceTest", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public RegisterPlaceResponseBody registerPlaceHandlerTest(HttpServletRequest request, @RequestBody RegisterPlaceRequestBody requestBody)
  {
    return registerPlaceHandler(request, requestBody);
  } // .end of registerPlaceHandlerTest

  @CrossOrigin(origins = AppConstants.CONSOLE_SITE_URL,  methods = {RequestMethod.POST}, allowedHeaders = {"*"}, exposedHeaders = {"Access-Control-Allow-Origin"})
  @RequestMapping(value = "/console/registerPlace", method = RequestMethod.POST, headers = "Accept=application/json", produces=MediaType.APPLICATION_JSON_VALUE)
  public RegisterPlaceResponseBody registerPlaceHandler(HttpServletRequest request, @RequestBody RegisterPlaceRequestBody requestBody)
  {
    // TASKS: Pre
    long startTime = Calendar.getInstance().getTimeInMillis();

    // TASK #1: Prepare response object
    RegisterPlaceResponseBody responseBody = new RegisterPlaceResponseBody();
    responseBody.status = RequestStatus.UNKNOWN_EXCEPTION;

    // (1) REGISTRATION
    //     - place_table (company name, placeId)
    //       - place_access_table
    //         - place_access_properties_table
    //       - place_role_table
    //       - place_settings_table
    //       - place_module_table
    //       - place_workflow
    //     - inventory_category_table

    // Validate Session
    UserSessionBean sessionObj = userService.getSessionById( requestBody.sessionId );
    if (sessionObj==null || sessionObj.isActive()==false)
    {
      responseBody.status = RequestStatus.INVALID_SESSION;
    }
    else
    {
      UserBean userObj = userService.getUserBySessionId(sessionObj.getId(), true);

      // Place Object
      PlaceBean placeObj = new PlaceBean();
      placeObj.setId(requestBody.companyUid);
      placeObj.setName(requestBody.companyName);
      placeObj.setCompanyName(requestBody.companyName);
      placeObj.setCategory("Local Business");
      placeObj.setSubcategory(requestBody.businessType);
      placeObj.setCreatedBy(userObj.getId());
      placeObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

      // UserAccessRightBean / PlaceAccessBean / PlaceRoleBean
      setupAccess(placeObj, userObj, requestBody.businessType);

      // PlaceModuleBean
      setupPlaceModule(placeObj, userObj, requestBody.businessType);

      // PlaceSettingsBean
      setupPlaceSettings(placeObj, userObj, requestBody.businessType);

      // PlaceWorkflowBean
      setupPlaceWorkflow(placeObj, userObj, requestBody.businessType);

      // PlaceDocumentBean
      setupPlaceDocument(placeObj, userObj, requestBody.businessType);

      // Inventory
      List<InventoryCategoryBean> categoryList = setupInventory(placeObj, userObj);

      // Save to DB
      userService.saveOrUpdateUser(userObj, userObj.getId());
      placeService.saveOrUpdatePlace(placeObj, userObj.getId());
      for (InventoryCategoryBean categoryObj : categoryList) {
        inventoryService.saveOrUpdateCategory(categoryObj, userObj.getId());
      }
    }

    // Finishing responseObj
    long endTime = Calendar.getInstance().getTimeInMillis();
    responseBody.elapsedTimeInMillis = endTime - startTime;
    responseBody.status = RequestStatus.REQUEST_SUCCESS;

    return responseBody;
  } // .end of registerPlaceHandler

  private void setupAccess(PlaceBean placeObj, UserBean userObj, String businessType)
  {
    String[] moduleList =
      {moduleConstants.MODULE_DASHBOARD, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_CALENDAR, moduleConstants.MODULE_INVENTORY,
        moduleConstants.MODULE_RELATION, moduleConstants.MODULE_REPORTS, moduleConstants.MODULE_SETTINGS};
    String[] modulePropKeyList =
      {moduleConstants.MODULE_DASHBOARD_PROP_KEY, moduleConstants.MODULE_BILLING_PROP_KEY, moduleConstants.MODULE_CALENDAR_PROP_KEY, moduleConstants.MODULE_INVENTORY_PROP_KEY,
        moduleConstants.MODULE_RELATION_PROP_KEY, moduleConstants.MODULE_REPORTS_PROP_KEY, moduleConstants.MODULE_SETTINGS_PROP_KEY};

    // UserAccessRightBean
		/*for (String moduleId : moduleList) {
			UserAccessRightBean userAccessRightObj = new UserAccessRightBean();
			userAccessRightObj.setUserId(userObj.getId());
			userAccessRightObj.setPlaceId(placeObj.getId()); 
			userAccessRightObj.setFunctionId(moduleId); 
			userAccessRightObj.setReadable(true);
			userAccessRightObj.setWritable(true);
			userAccessRightObj.setCreatedBy(userObj.getId());
			userAccessRightObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
			// Push to user object
			userObj.accessRightList.add(userAccessRightObj);
		}*/

    // PlaceAccessBean
    PlaceAccessBean placeAccessObj = new PlaceAccessBean();
    placeAccessObj.setPlaceId(placeObj.getId());
    placeAccessObj.setRoleName(placeConstants.PLACE_ROLE_ADMINISTRATOR);
    placeAccessObj.setCreatedBy(userObj.getId());
    placeAccessObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
    // Push to place object
    placeObj.accessList.add(placeAccessObj);
    // PlaceAccessPropertiesBean
    for (int i = 0 ; i < moduleList.length ; i++) {
      PlaceAccessPropertiesBean accessPropObj = new PlaceAccessPropertiesBean();
      accessPropObj.setAccessId(placeAccessObj.getId());
      accessPropObj.setGroupName("Root Functions");
      accessPropObj.setPropSeqno(i+1);
      accessPropObj.setPropKey(modulePropKeyList[i]);
      accessPropObj.setPropName(moduleList[i]);
      accessPropObj.setPropType("Select");
      accessPropObj.setPropContent("No Access, Readable, Writable");
      accessPropObj.setPropValue("Writable");
      accessPropObj.setCreatedBy(userObj.getId());
      accessPropObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

      placeAccessObj.propertiesList.add(accessPropObj);
    }

    // PlaceRoleBean
    PlaceRoleBean placeRoleObj = new PlaceRoleBean();
    placeRoleObj.setUserId(userObj.getId());
    placeRoleObj.setPlaceId(placeObj.getId());
    placeRoleObj.setRole(placeConstants.PLACE_ROLE_ADMINISTRATOR);
    placeRoleObj.setCreatedBy(userObj.getId());
    placeRoleObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
    // Push to place object
    placeObj.roleList.add(placeRoleObj);
  } // .end of setupAccess

  private void setupPlaceSettings(PlaceBean placeObj, UserBean userObj, String businessType)
  {
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_GENERAL, "General", 1, settingsConstants.SETTINGS_POS_KEY_GENERAL_ITEMVIEW_TYPE, "Item View", "Select", "List View, Mansory View", "List View");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_GENERAL, "General", 2, settingsConstants.SETTINGS_POS_KEY_GENERAL_CURRENCY, "Currency", "Select", "MYR,SGD", "MYR");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_GENERAL, "General", 3, settingsConstants.SETTINGS_POS_KEY_GENERAL_ROUND_TO_MULTIPLE_FIVE, "Round to Multiple of Five", "Boolean", "", "0");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_TAXATION, "GST", 1, settingsConstants.SETTINGS_POS_KEY_GST_ENABLED, "GST Enabled", "Boolean", "", "0");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_TAXATION, "GST", 2, settingsConstants.SETTINGS_POS_KEY_GST_TAX_INVOICE_NUMBER, "Tax Invoice Number", "Text", "", "");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_ORDER, "Billing", 1, settingsConstants.SETTINGS_POS_KEY_BILLING_ENABLED, "Enable Internal Order", "Boolean", "", "0");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_ORDER, "Billing", 2, settingsConstants.SETTINGS_POS_KEY_BILLING_FULL_TEMPLATE, "Selected Internal Order", "Select", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_ORDER, "Billing", 3, settingsConstants.SETTINGS_POS_KEY_BILLING_NO_PREFIX, "Billing No. Prefix", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_ORDER, "Billing", 4, settingsConstants.SETTINGS_POS_KEY_BILLING_NO_MAX, "Billing Max No.", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_ORDER, "Billing", 5, settingsConstants.SETTINGS_POS_KEY_BILLING_NO_NEXT, "Billing Next No.", "Text", "", "");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_SALES_INVOICE, "Sales Invoice", 1, settingsConstants.SETTINGS_POS_KEY_SALES_INVOICE_ENABLED, "Enable Sales Invoice", "Boolean", "", "0");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_SALES_INVOICE, "Sales Invoice", 2, settingsConstants.SETTINGS_POS_KEY_SALES_INVOICE_TEMPLATE, "Selected Sales Invoice", "Select", "", "");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_TAX_INVOICE, "Tax Invoice", 1, settingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_ENABLED, "Enable Tax Invoice", "Boolean", "", "0");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_TAX_INVOICE, "Tax Invoice", 2, settingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_TEMPLATE, "Selected Tax Invoice", "Select", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_TAX_INVOICE, "Tax Invoice", 3, settingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_NO_PREFIX, "Tax Invoice No. Prefix", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_TAX_INVOICE, "Tax Invoice", 4, settingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_NO_MAX, "Tax Invoice Max No.", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_TAX_INVOICE, "Tax Invoice", 5, settingsConstants.SETTINGS_POS_KEY_TAX_INVOICE_NO_NEXT, "Tax Invoice Next No.", "Text", "", "");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT_RECEIPT, "Payment Receipt", 1, settingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_ENABLED, "Enable Payment Receipt", "Boolean", "", "0");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT_RECEIPT, "Payment Receipt", 2, settingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_TEMPLATE, "Selected Payment Receipt", "Select", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT_RECEIPT, "Payment Receipt", 3, settingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_NO_PREFIX, "Payment Receipt No. Prefix", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT_RECEIPT, "Payment Receipt", 4, settingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_NO_MAX, "Payment Receipt Max No.", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT_RECEIPT, "Payment Receipt", 5, settingsConstants.SETTINGS_POS_KEY_PAYMENT_RECEIPT_NO_NEXT, "Payment Receipt Next No.", "Text", "", "");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT_VOUCHER, "Payment Voucher", 1, settingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_ENABLED, "Enable Payment Voucher", "Boolean", "", "0");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT_VOUCHER, "Payment Voucher", 2, settingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_TEMPLATE, "Selected Payment Voucher", "Select", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT_VOUCHER, "Payment Voucher", 3, settingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_NO_PREFIX, "Payment Voucher No. Prefix", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT_VOUCHER, "Payment Voucher", 4, settingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_NO_MAX, "Payment Voucher Max No.", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT_VOUCHER, "Payment Voucher", 5, settingsConstants.SETTINGS_POS_KEY_PAYMENT_VOUCHER_NO_NEXT, "Payment Voucher Next No.", "Text", "", "");

    //addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, "", "Printable Document", 1, "PLACE_SETTINGS_KEY_INVOICE_SELECTED", "Selected Invoice", "Select", "INV001_001,INV001_002", "INV001_001");
    //addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, "", "Printable Document", 2, "PLACE_SETTINGS_KEY_RECEIPT_SELECTED", "Selected Receipt", "Select", "RCP001_001,RCP001_002", "RCP001_001");
    //addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, "", "Printable Document", 3, "PLACE_SETTINGS_KEY_FULL_ORDER_SELECTED", "Selected Full Order", "Select", "FOR001_001", "FOR001_001");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_QUOTATION, "Quotation", 1, settingsConstants.SETTINGS_POS_KEY_QUOTATION_ENABLED, "Enable Quotation", "Boolean", "", "0");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_QUOTATION, "Quotation", 2, settingsConstants.SETTINGS_POS_KEY_QUOTATION_TEMPLATE, "Selected Quotation", "Select", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_QUOTATION, "Quotation", 3, settingsConstants.SETTINGS_POS_KEY_QUOTATION_NO_PREFIX, "Quotation No. Prefix", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_QUOTATION, "Quotation", 4, settingsConstants.SETTINGS_POS_KEY_QUOTATION_NO_MAX, "Quotation Max No.", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_QUOTATION, "Quotation", 5, settingsConstants.SETTINGS_POS_KEY_QUOTATION_NO_NEXT, "Quotation Next No.", "Text", "", "");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_DELIVERY_ORDER, "Delivery Order", 1, settingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_ENABLED, "Enable Delivery Order", "Boolean", "", "0");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_DELIVERY_ORDER, "Delivery Order", 2, settingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_TEMPLATE, "Selected Delivery Order", "Select", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_DELIVERY_ORDER, "Delivery Order", 3, settingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_NO_PREFIX, "Delivery Order No. Prefix", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_DELIVERY_ORDER, "Delivery Order", 4, settingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_NO_MAX, "Delivery Order Max No.", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_DELIVERY_ORDER, "Delivery Order", 5, settingsConstants.SETTINGS_POS_KEY_DELIVERY_ORDER_NO_NEXT, "Delivery Order Next No.", "Text", "", "");

    if ("cafe".equals(businessType)) {
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Food Order", 1, settingsConstants.SETTINGS_POS_KEY_FOOD_ORDER_ENABLED, "Enable Food Order", "Boolean", "", "0");
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Food Order", 2, settingsConstants.SETTINGS_POS_KEY_FOOD_ORDER_TEMPLATE, "Selected Food Order", "Select", "", "");
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Food Order", 3, settingsConstants.SETTINGS_POS_KEY_FOOD_ORDER_LABEL, "Food Order Item Label", "Text", "", "");
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Drink Order", 4, settingsConstants.SETTINGS_POS_KEY_DRINK_ORDER_ENABLED, "Enable Drink Order", "Boolean", "", "0");
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Drink Order", 5, settingsConstants.SETTINGS_POS_KEY_DRINK_ORDER_TEMPLATE, "Selected Drink Order", "Select", "", "");
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Drink Order", 6, settingsConstants.SETTINGS_POS_KEY_DRINK_ORDER_LABEL, "Drink Order Item Label", "Text", "", "");
    }
    if ("restaurant".equals(businessType)) {
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Food Order", 1, settingsConstants.SETTINGS_POS_KEY_FOOD_ORDER_ENABLED, "Enable Food Order", "Boolean", "", "0");
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Food Order", 2, settingsConstants.SETTINGS_POS_KEY_FOOD_ORDER_TEMPLATE, "Selected Food Order", "Select", "", "");
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Food Order", 3, settingsConstants.SETTINGS_POS_KEY_FOOD_ORDER_LABEL, "Food Order Item Label", "Text", "", "");
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Drink Order", 4, settingsConstants.SETTINGS_POS_KEY_DRINK_ORDER_ENABLED, "Enable Drink Order", "Boolean", "", "0");
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Drink Order", 5, settingsConstants.SETTINGS_POS_KEY_DRINK_ORDER_TEMPLATE, "Selected Drink Order", "Select", "", "");
      addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_BACKOFFICE, "Drink Order", 6, settingsConstants.SETTINGS_POS_KEY_DRINK_ORDER_LABEL, "Drink Order Item Label", "Text", "", "");
    }

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT, "Payment", 1, settingsConstants.SETTINGS_POS_KEY_PAYMENT_DEFAULT_OPTION, "Default Payment", "Select", "Cash,Credit Card,Cheque", "Cash");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT, "Cash", 2, settingsConstants.SETTINGS_POS_KEY_PAYMENT_OPTION_CASH_ENABLED, "Enable Cash Option", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT, "Credit Card", 3, settingsConstants.SETTINGS_POS_KEY_PAYMENT_OPTION_CREDIT_CARD_ENABLED, "Enable Credit Card Option", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT, "Credit Card", 4, settingsConstants.SETTINGS_POS_KEY_PAYMENT_CREDIT_CARD_INFO_REQUIRED, "Require Credit Card Info?", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT, "Credit Card", 5, settingsConstants.SETTINGS_POS_KEY_PAYMENT_CREDIT_CARD_TYPE, "Available Credit Card Type", "Select Multiple", "Visa,Master,Amex,Diners Club,JCB,Discover,MyDebit", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT, "Cheque", 6, settingsConstants.SETTINGS_POS_KEY_PAYMENT_OPTION_CHEQUE_ENABLED, "Enable Cheque Option", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_PAYMENT, "Cheque", 7, settingsConstants.SETTINGS_POS_KEY_PAYMENT_CHEQUE_INFO_REQUIRED, "Require Cheque Info?", "Boolean", "", "1");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, "Customer Search", 1, settingsConstants.SETTINGS_POS_KEY_COL_GENDER, "Column: Customer Gender", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, "Customer Search", 2, settingsConstants.SETTINGS_POS_KEY_COL_EMAIL, "Column: Customer Email", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, "Customer Search", 3, settingsConstants.SETTINGS_POS_KEY_COL_CONTACT, "Column: Customer Contact", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, "Customer Search", 4, settingsConstants.SETTINGS_POS_KEY_COL_DOB, "Column: Customer DOB", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_CUSTOMER_SEARCH, "Customer Search", 5, settingsConstants.SETTINGS_POS_KEY_COL_LAST_BILLING, "Column: Last Billing", "Boolean", "", "1");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, "Order Search", 1, settingsConstants.SETTINGS_POS_KEY_COL_INVOICE_NUMBER, "Column: Billing Invoice No.", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, "Order Search", 2, settingsConstants.SETTINGS_POS_KEY_COL_DATE_TIME, "Column: Billing Date/Time", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, "Order Search", 3, settingsConstants.SETTINGS_POS_KEY_COL_CUSTOMER, "Column: Billing Customer", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, "Order Search", 4, settingsConstants.SETTINGS_POS_KEY_COL_TOTAL_AMOUNT, "Column: Total Amount", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_BILLING, moduleConstants.MODULE_BILLING_SUB_ORDER_SEARCH, "Order Search", 5, settingsConstants.SETTINGS_POS_KEY_COL_TOTAL_PAYMENT, "Column: Total Payment", "Boolean", "", "1");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_RELATION, moduleConstants.MODULE_RELATION_SUB_CUSTOMER, "Customer No Format", 1, settingsConstants.SETTINGS_RELATION_KEY_CUSTOMER_NO_PREFIX, "Customer No. Prefix", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_RELATION, moduleConstants.MODULE_RELATION_SUB_CUSTOMER, "Customer No Format", 2, settingsConstants.SETTINGS_RELATION_KEY_CUSTOMER_NO_MAX, "Customer Max No.", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_RELATION, moduleConstants.MODULE_RELATION_SUB_CUSTOMER, "Customer No Format", 3, settingsConstants.SETTINGS_RELATION_KEY_CUSTOMER_NO_NEXT, "Customer Next No.", "Text", "", "");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_RELATION, moduleConstants.MODULE_RELATION_SUB_EMPLOYEE, "Employee No Format", 1, settingsConstants.SETTINGS_RELATION_KEY_EMPLOYEE_NO_PREFIX, "Employee No. Prefix", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_RELATION, moduleConstants.MODULE_RELATION_SUB_EMPLOYEE, "Employee No Format", 2, settingsConstants.SETTINGS_RELATION_KEY_EMPLOYEE_NO_MAX, "Employee Max No.", "Text", "", "");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_RELATION, moduleConstants.MODULE_RELATION_SUB_EMPLOYEE, "Employee No Format", 3, settingsConstants.SETTINGS_RELATION_KEY_EMPLOYEE_NO_NEXT, "Employee Next No.", "Text", "", "");

    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_INVENTORY, moduleConstants.MODULE_INVENTORY_SUB_GENERAL, "Show/Hide Category", 1, settingsConstants.SETTINGS_INVENTORY_KEY_SHOW_RAW_CATEGORY, "Show Raw Category", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_INVENTORY, moduleConstants.MODULE_INVENTORY_SUB_GENERAL, "Show/Hide Category", 2, settingsConstants.SETTINGS_INVENTORY_KEY_SHOW_PRODUCT_CATEGORY, "Show Product Category", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_INVENTORY, moduleConstants.MODULE_INVENTORY_SUB_GENERAL, "Show/Hide Category", 3, settingsConstants.SETTINGS_INVENTORY_KEY_SHOW_SERVICE_CATEGORY, "Show Service Category", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_INVENTORY, moduleConstants.MODULE_INVENTORY_SUB_GENERAL, "Show/Hide Category", 4, settingsConstants.SETTINGS_INVENTORY_KEY_SHOW_EVENT_CATEGORY, "Show Event Category", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_INVENTORY, moduleConstants.MODULE_INVENTORY_SUB_GENERAL, "Show/Hide Category", 5, settingsConstants.SETTINGS_INVENTORY_KEY_SHOW_DISCOUNT_CATEGORY, "Show Discount Category", "Boolean", "", "1");
    addSettingsToPlace(placeObj, userObj, moduleConstants.MODULE_INVENTORY, moduleConstants.MODULE_INVENTORY_SUB_GENERAL, "Show/Hide Category", 6, settingsConstants.SETTINGS_INVENTORY_KEY_SHOW_TAX_CATEGORY, "Show Tax Category", "Boolean", "", "1");
  }

  private void setupPlaceModule(PlaceBean placeObj, UserBean userObj, String businessType) {
    if ("cafe".equals(businessType)) {
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_DASHBOARD, "cafe_001", "/console/dashboard/das001/view/das001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_CALENDAR, "cafe_001", "/console/calendar/cal001/view/cal001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_BILLING, "cafe_001", "/console/billing/bil002/view/bil002.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_INVENTORY, "cafe_001", "/console/inventory/inv002/view/inv002.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_RELATION, "cafe_001", "/console/relation/rel001/view/rel001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_REPORTS, "cafe_001", "/console/reports/rep001/view/rep001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_SETTINGS, "cafe_001", "/console/settings/set001/view/set001.jsp"));
    }
    if ("grocery".equals(businessType)) {
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_DASHBOARD, "grocery_001", "/console/dashboard/das001/view/das001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_CALENDAR, "grocery_001", "/console/calendar/cal001/view/cal001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_BILLING, "grocery_001", "/console/billing/bil001/view/bil001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_INVENTORY, "grocery_001", "/console/inventory/inv002/view/inv002.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_RELATION, "grocery_001", "/console/relation/rel001/view/rel001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_REPORTS, "grocery_001", "/console/reports/rep001/view/rep001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_SETTINGS, "grocery_001", "/console/settings/set001/view/set001.jsp"));
    }
    if ("restaurant".equals(businessType)) {
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_DASHBOARD, "restaurant_001", "/console/dashboard/das001/view/das001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_CALENDAR, "restaurant_001", "/console/calendar/cal001/view/cal001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_BILLING, "restaurant_001", "/console/billing/bil002/view/bil002.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_INVENTORY, "restaurant_001", "/console/inventory/inv002/view/inv002.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_RELATION, "restaurant_001", "/console/relation/rel001/view/rel001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_REPORTS, "restaurant_001", "/console/reports/rep001/view/rep001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_SETTINGS, "restaurant_001", "/console/settings/set001/view/set001.jsp"));
    }
    if ("tailor".equals(businessType)) {
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_DASHBOARD, "tailor_001", "/console/dashboard/das001/view/das001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_CALENDAR, "tailor_001", "/console/calendar/cal001/view/cal001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_BILLING, "tailor_001", "/console/billing/bil001/view/bil001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_INVENTORY, "tailor_001", "/console/inventory/inv002/view/inv002.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_RELATION, "tailor_001", "/console/relation/rel001/view/rel001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_REPORTS, "tailor_001", "/console/reports/rep001/view/rep001.jsp"));
      placeObj.moduleList.add(createPlaceModule(placeObj, userObj, moduleConstants.MODULE_SETTINGS, "tailor_001", "/console/settings/set001/view/set001.jsp"));
    }
  } // .end of setupPlaceModule

  private void setupPlaceWorkflow(PlaceBean placeObj, UserBean userObj, String businessType)
  {
    PlaceWorkflowBean workflowObj1 = new PlaceWorkflowBean();
    workflowObj1.setPlaceId(placeObj.getId());
    workflowObj1.setModuleId(moduleConstants.MODULE_BILLING);
    workflowObj1.setSubModuleId(moduleConstants.MODULE_BILLING_SUB_WORKFLOW);
    workflowObj1.setCreatedBy(userObj.getId());
    workflowObj1.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
    placeObj.workflowList.add(workflowObj1);

    PlaceWorkflowBean workflowObj2 = new PlaceWorkflowBean();
    workflowObj2.setPlaceId(placeObj.getId());
    workflowObj2.setModuleId(moduleConstants.MODULE_BILLING);
    workflowObj2.setSubModuleId(moduleConstants.MODULE_BILLING_SUB_SCHEDULE);
    workflowObj2.setCreatedBy(userObj.getId());
    workflowObj2.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
    placeObj.workflowList.add(workflowObj2);

    workflowObj1.eventList.add(createPlaceWorkflowEvent(workflowObj1, userObj, 1, "eventKey_NEW", "New", "New Billing"));
    workflowObj1.eventList.add(createPlaceWorkflowEvent(workflowObj1, userObj, 2, "eventKey_OPEN", "Opened", "Open Billing"));
    workflowObj1.eventList.add(createPlaceWorkflowEvent(workflowObj1, userObj, 3, "eventKey_PAYMENT", "Payment", "Payment Made"));
    workflowObj1.eventList.add(createPlaceWorkflowEvent(workflowObj1, userObj, 4, "eventKey_PAID", "Paid", "Paid Billing"));
    workflowObj1.eventList.add(createPlaceWorkflowEvent(workflowObj1, userObj, 5, "eventKey_CLOSED", "Closed", "Closed Billing"));
    workflowObj1.eventList.add(createPlaceWorkflowEvent(workflowObj1, userObj, 6, "eventKey_DELETED", "Deleted", "Deleted Billing"));
  } // .end of setupPlaceWorkflow

  private void setupPlaceDocument(PlaceBean placeObj, UserBean userObj, String businessType)
  {
    placeObj.documentList.add(createPlaceDocument(placeObj, userObj, "INV001-001"));
    placeObj.documentList.add(createPlaceDocument(placeObj, userObj, "RCP001-001"));
    placeObj.documentList.add(createPlaceDocument(placeObj, userObj, "FOR001-001"));
    placeObj.documentList.add(createPlaceDocument(placeObj, userObj, "QUO001-001"));

    if ("cafe".equals(businessType)) {
      placeObj.documentList.add(createPlaceDocument(placeObj, userObj, "FOD001-001"));
      placeObj.documentList.add(createPlaceDocument(placeObj, userObj, "DRK001-001"));
    }
    if ("restaurant".equals(businessType)) {
      placeObj.documentList.add(createPlaceDocument(placeObj, userObj, "FOD001-001"));
      placeObj.documentList.add(createPlaceDocument(placeObj, userObj, "DRK001-001"));
    }
  } // .end of setupPlaceDocument

  private List<InventoryCategoryBean> setupInventory(PlaceBean placeObj, UserBean userObj)
  {
    InventoryCategoryBean categoryObj1 = createCategory(placeObj, userObj, inventoryConstants.ITEM_TYPE_RAW, "Root Raw", 1);
    InventoryCategoryBean categoryObj2 = createCategory(placeObj, userObj, inventoryConstants.ITEM_TYPE_PRODUCT, "Root Product", 2);
    InventoryCategoryBean categoryObj3 = createCategory(placeObj, userObj, inventoryConstants.ITEM_TYPE_SERVICE, "Root Service", 3);
    InventoryCategoryBean categoryObj4 = createCategory(placeObj, userObj, inventoryConstants.ITEM_TYPE_EVENT, "Root Event", 4);
    InventoryCategoryBean categoryObj5 = createCategory(placeObj, userObj, inventoryConstants.ITEM_TYPE_DISCOUNT, "Root Discount", 5);
    InventoryCategoryBean categoryObj6 = createCategory(placeObj, userObj, inventoryConstants.ITEM_TYPE_TAX, "Root Tax", 6);

    List<InventoryCategoryBean> list = new ArrayList<InventoryCategoryBean>();
    list.add(categoryObj1);
    list.add(categoryObj2);
    list.add(categoryObj3);
    list.add(categoryObj4);
    list.add(categoryObj5);
    list.add(categoryObj6);

    return list;
  }

  private void addSettingsToPlace(PlaceBean placeObj, UserBean userObj, String moduleId, String subModuleId, String groupName, int seqno, String propKey, String propName, String propType, String propContent, String propValue)
  {
    PlaceSettingsBean settingsObj = new PlaceSettingsBean();
    settingsObj.setPlaceId(placeObj.getId());
    settingsObj.setModuleId(moduleId);
    settingsObj.setSubModuleId(subModuleId);
    settingsObj.setGroupName(groupName);
    settingsObj.setPropSeqno(seqno);
    settingsObj.setPropKey(propKey);
    settingsObj.setPropName(propName);
    settingsObj.setPropType(propType);
    settingsObj.setPropContent(propContent);
    settingsObj.setPropValue(propValue);
    settingsObj.setRemarks(propName);
    settingsObj.setCreatedBy(userObj.getId());
    settingsObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));
    // Push to place object
    placeObj.settingsList.add(settingsObj);

  } // .end of addSettingsToPlace

  private PlaceModuleBean createPlaceModule(PlaceBean placeObj, UserBean userObj, String moduleId, String layoutId, String layoutPath) {
    PlaceModuleBean moduleObj = new PlaceModuleBean();
    moduleObj.setPlaceId(placeObj.getId());
    moduleObj.setModuleId(moduleId);
    moduleObj.setModuleLayoutId(layoutId);
    moduleObj.setModuleLayoutPath(layoutPath);
    moduleObj.setCreatedBy(userObj.getId());
    moduleObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

    return moduleObj;
  } // .end of createPlaceModule

  private InventoryCategoryBean createCategory(PlaceBean placeObj, UserBean userObj, String itemType, String name, int seqno) {
    InventoryCategoryBean categoryObj = new InventoryCategoryBean();
    categoryObj.setId(inventoryConstants.SYSTEM_DEFINED_MASTER_ID + "-" + itemType + "-" + placeObj.getId());
    categoryObj.setPlaceId(placeObj.getId());
    categoryObj.setBusinessTypeId("");
    categoryObj.setParentCategoryId("root");
    categoryObj.setParentCategoryName("0");
    categoryObj.setItemType(itemType);
    categoryObj.setName(name);
    categoryObj.setSeqno(seqno);
    categoryObj.setSystemDefined(true);
    categoryObj.setPosVisible(true);
    categoryObj.setScmVisible(false);
    categoryObj.setCreatedBy(userObj.getId());
    categoryObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

    return categoryObj;
  } // .end of createCategory

  private PlaceWorkflowEventBean createPlaceWorkflowEvent(PlaceWorkflowBean workflowObj, UserBean userObj, int seqno, String eventKey, String eventTitle, String eventDescription) {
    PlaceWorkflowEventBean eventObj = new PlaceWorkflowEventBean();
    eventObj.setWorkflowId(workflowObj.getId());
    eventObj.setSeqno(seqno);
    eventObj.setEventKey(eventKey);
    eventObj.setEventTitle(eventTitle);
    eventObj.setEventDescription(eventDescription);
    eventObj.setTrackedOn(null);
    eventObj.setTrackedBy(null);
    eventObj.setCreatedBy(userObj.getId());
    eventObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

    return eventObj;
  } // .end of createPlaceWorkflowEvent

  private PlaceDocumentBean createPlaceDocument(PlaceBean placeObj, UserBean userObj, String documentId) {
    PlaceDocumentBean documentObj = new PlaceDocumentBean();
    documentObj.setPlaceId(placeObj.getId());
    documentObj.setDocumentId(documentId);
    documentObj.setCreatedBy(userObj.getId());
    documentObj.setCreatedOn(new Timestamp(Calendar.getInstance().getTimeInMillis()));

    return documentObj;
  } // .end of PlaceDocumentBean

  //--------------------------------------------------------------------------

  private UserSessionBean getActiveSession(UserBean userObj)
  {
    UserSessionBean activeSessionObj = null;
    long currentTimeInMillis = Calendar.getInstance().getTimeInMillis();

    for (UserSessionBean sessionObj : userObj.sessionList)
    {
      long validUntil = sessionObj.getLastAccessedOn().getTime() + sessionObj.getValidityPeriod();
      if (validUntil > currentTimeInMillis)
      {
        activeSessionObj = sessionObj;
      }
      else
      {
        sessionObj.setActive( false );
      }
    }

    return activeSessionObj;
  }

  private UserSessionBean getNewSession(HttpServletRequest request, LoginRequestBody requestBody, UserBean userObj)
  {
    UserSessionBean sessionObj = new UserSessionBean();
    sessionObj.setUserId(userObj.getId());
    sessionObj.setEmail(userObj.getEmail());
    sessionObj.setRemember(requestBody.rememberMe);
    sessionObj.setRemoteAddress(getClientAddress(request));
    sessionObj.setUserAgent(request.getHeader("User-Agent"));
    sessionObj.setActive( true );
    sessionObj.setStartedOn( new Timestamp(Calendar.getInstance().getTimeInMillis()) );
    sessionObj.setReadableStartedOn( FormatterService.DATE_FORMAT_FULL.format(sessionObj.getStartedOn()) );
    sessionObj.setLastAccessedOn( new Timestamp(Calendar.getInstance().getTimeInMillis()) );
    sessionObj.setReadableLastAccessedOn( FormatterService.DATE_FORMAT_FULL.format(sessionObj.getLastAccessedOn()) );
    sessionObj.setValidityPeriod( 365 * 24 * 60 * 60 * 1000 );
    sessionObj.setCreatedOn( new Timestamp(Calendar.getInstance().getTimeInMillis()) );
    sessionObj.setCreatedBy( userObj.getId() );
    //userSession.setStatus(UserConstants.SESSION_STATUS_VALID);

    return sessionObj;
  }
}  