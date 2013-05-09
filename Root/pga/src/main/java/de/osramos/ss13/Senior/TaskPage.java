/*
 * Copyright (c) 2013 by Dirk Riehle, http://dirkriehle.com
 *
 * This file is part of the Amos SS13 Project - Productive Games Development (PGA) application.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * 
 * Software Developers in alphabetical order:
 * Nina Aures
 * Alexander Schmidt
 * Sascha Stroebel
 */

package de.osramos.ss13.Senior;

import java.util.List;

import org.apache.wicket.markup.html.WebPage;
import org.apache.wicket.markup.html.basic.Label;
import org.apache.wicket.markup.html.form.DropDownChoice;
import org.apache.wicket.markup.html.form.Form;
import org.apache.wicket.markup.html.form.TextField;
import org.apache.wicket.model.PropertyModel;
import org.apache.wicket.request.mapper.parameter.PageParameters;
import org.apache.wicket.util.value.ValueMap;

import de.osramos.ss13.HibernateTools;
import de.osramos.ss13.Model.TaskDB;

public class TaskPage extends WebPage implements de.osramos.ss13.Right.Senior{
	private static final long serialVersionUID = 1L;

	private final ValueMap properties = new ValueMap();
	
	public TaskPage(final PageParameters parameters) {
		
		add(new Label("feedbacksuccess", new PropertyModel<String>(properties, "feedbacksuccess")));
		add(new Label("feedbackerror", new PropertyModel<String>(properties, "feedbackerror")));
		add(new SeniorTaskPageForm("form"));
		
	}
	
	
	public final class SeniorTaskPageForm extends Form<Void>
    {
		
		
		public SeniorTaskPageForm(String id) {
			super(id);

			List<String> trainees = HibernateTools.GetStringList("select firstname || ' ' || lastname AS fullname from userdb");
			add(new TextField<String>("taskname", new PropertyModel<String>(properties, "taskname")));
			add(new DropDownChoice<String>("trainee", new PropertyModel<String>(properties, "trainee"), trainees));
			add(new TextField<String>("gpscoordinate", new PropertyModel<String>(properties, "gpscoordinate")));
			
		}

		@Override
	    public final void onSubmit()
	    {
			String errors = "";
			properties.remove("feedbacksuccess");
			properties.remove("feedbackerror");
			
			if(null == properties.getString("trainee"))
	        	errors += " Please select a Trainee";
	        if(null == properties.getString("taskname"))
	        	errors += " Please enter Taskname";
	        if(null == properties.getString("gpscoordinate"))
	        	errors += " Please enter a GPS/Coordinate";
	        else if (false == properties.getString("gpscoordinate").matches("(-+)?\\d+\\.\\d+,(-+)?\\d+\\.\\d+"))
	        {
	        	errors += " Please enter VALID GPS/Coordinate";
	        }
	        
	        
	        if(errors.length() > 0)
	        {
	        	properties.put("feedbackerror",errors);
	        	return;
	        }
	        
	        TaskDB t = new TaskDB();
	        t.setTaskname(properties.getString("taskname"));
	        t.setTrainee(properties.getString("trainee"));
	        t.setGpscoordinate(properties.getString("gpscoordinate"));
	        t.setDescription("");
	        HibernateTools.save(t);
			
	        properties.put("feedbacksuccess","Success!");
	        properties.remove("taskname");
	        properties.remove("trainee");
	        properties.remove("gpscoordinate");
	        
	    }
    }

}
