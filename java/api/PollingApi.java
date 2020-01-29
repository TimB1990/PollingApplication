package api;

import java.sql.SQLException;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import controllers.AppController;
import models.ErrorData;
import models.PollData;

@Path("/PollingApplication")
public class PollingApi {

    @GET
    @Path("/poll")
    @Produces(MediaType.APPLICATION_JSON)
    public Response getPollDataOnCheck(){
        Object responseEntity = new Object();
        try{

            PollData data = AppController.getPollDataOnCheck("fourth.test.ip");
            responseEntity = (PollData) data;
        }
        catch(SQLException e){

            ErrorData error = new ErrorData(500,"server error", "message: " + e);
            responseEntity = (ErrorData) error;
        }

        return Response.status(Response.Status.OK).entity(responseEntity).build();
    }
}