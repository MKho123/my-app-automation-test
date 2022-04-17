package tests;

import org.json.simple.JSONObject;
import org.testng.annotations.Test;

import static io.restassured.RestAssured.*;

import io.restassured.http.ContentType;
import static org.hamcrest.Matchers.*;

public class APITesting {
	@Test
	public void getApiTesting() {
		baseURI = "https://reqres.in/api";
		given().
			get("/users?page=2").
		then().
			statusCode(200).
			body("data[3].email", equalTo("byron.fields@reqres.in")).
			body("data[3].first_name", equalTo("Byron")).
			body("data[3].last_name", equalTo("Fields")).
			body("data[3].avatar", equalTo("https://reqres.in/img/faces/10-image.jpg"));
	}
	
	@Test
	public void postApiTesting() {
		JSONObject request = new JSONObject();
		request.put("name", "Mickey Mouse");
		request.put("job", "Actor");
		
		System.out.println(request.toJSONString());
		
		baseURI = "https://reqres.in/api";
		given().
			header("content-type", "application/json").
			contentType(ContentType.JSON).
			accept(ContentType.JSON).
			body(request.toJSONString()).
		when().
			post("/users").
		then().
			statusCode(201).
			log().all();
	}
}
