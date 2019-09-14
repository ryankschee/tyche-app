
  function tycheesSecurity_hashPassword(password, salt) 
  {
	  return sha256(password + salt);
  } // .end of tycheesSecurity_hashPassword
  
  function tycheesSecurity_getSalt() 
  {
	  var saltInString = '';
	  var saltInArray = secureRandom(32);
	  for (var i = 0 ; i < saltInArray.length ; i++) {
		  saltInString = saltInString + String.fromCharCode(saltInArray[i]);
	  }    	  
	  return saltInString;
  } // .end of tycheesSecurity_getSalt
  
  function tycheesSecurity_validatePassword(password, minLength)
  {
	  var re = /[0-9]/;
      if(!re.test(password)) {
        //alert("Error: password must contain at least one number (0-9)!");
        return false;
      }
      re = /[a-z]/;
      if(!re.test(password)) {
        //alert("Error: password must contain at least one lowercase letter (a-z)!");
        return false;
      }
      re = /[A-Z]/;
      if(!re.test(password)) {
        //alert("Error: password must contain at least one uppercase letter (A-Z)!");
        return false;
      }
      
      if ($.trim(password).length < minLength) {
    	  return false;
      }
      
      return true;
  } // .end of tycheesSecurity_validatePassword