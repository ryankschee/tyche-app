package com.tychees.core.mail;

import java.util.logging.Logger;

import javax.ws.rs.core.MediaType;

import org.springframework.stereotype.Component;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;
import com.sun.jersey.api.client.filter.HTTPBasicAuthFilter;
import com.sun.jersey.core.util.MultivaluedMapImpl;

@Component
public class MailGunUtil {

	private static final Logger LOGGER = Logger.getLogger(MailGunUtil.class.getName());
	
	public static ClientResponse SendSimpleMessage() {
	    Client client = Client.create();
	    client.addFilter(new HTTPBasicAuthFilter("api", "key-b55cfbfaa76e782cbb595d4803b4740e"));
	    WebResource webResource = client.resource("https://api.mailgun.net/v3/sandbox7dae8ec6239d4b77acc89a4753f57e05.mailgun.org/messages");
	    MultivaluedMapImpl formData = new MultivaluedMapImpl();
	    formData.add("from", "Mailgun Sandbox <postmaster@sandbox7dae8ec6239d4b77acc89a4753f57e05.mailgun.org>");
	    formData.add("to", "Ryan Chee <ryan.kschee@gmail.com>");
	    formData.add("subject", "Hello Ryan Chee");
	    formData.add("text", "Congratulations Ryan Chee, you just sent an email with Mailgun!  You are truly awesome!");
	    return webResource.type(MediaType.APPLICATION_FORM_URLENCODED).
	                                        post(ClientResponse.class, formData);
	}
	// You can see a record of this email in your logs: https://mailgun.com/app/logs .

	// You can send up to 300 emails/day from this sandbox server.
	// Next, you should add your own domain so you can send 10,000 emails/month for free.
}