// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package de.osramos.ss13.proj1.model;

/*
 * #%L
 * proj1
 * %%
 * Copyright (C) 2013 Amos-Project
 * %%
 * Copyright (c) 2013 by Alexander Schmidt, Sascha Ströbel, Nina Aures, Riehle, http://dirkriehle.com
 * -
 * This file is part of the Amos Project - Productive Games application.
 * -
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as
 * published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 * -
 * This program is distributed in the hope that it will be useful, 
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 * -
 * You should have received a copy of the GNU Affero General Public
 * License along with this program. If not, see
 * <http://www.gnu.org/licenses/>.
 * #L%
 */

import de.osramos.ss13.proj1.model.Gpscoordinate;
import flexjson.JSONDeserializer;
import flexjson.JSONSerializer;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

privileged aspect Gpscoordinate_Roo_Json {
    
    public String Gpscoordinate.toJson() {
        return new JSONSerializer().exclude("*.class").serialize(this);
    }
    
    public String Gpscoordinate.toJson(String[] fields) {
        return new JSONSerializer().include(fields).exclude("*.class").serialize(this);
    }
    
    public static Gpscoordinate Gpscoordinate.fromJsonToGpscoordinate(String json) {
        return new JSONDeserializer<Gpscoordinate>().use(null, Gpscoordinate.class).deserialize(json);
    }
    
    public static String Gpscoordinate.toJsonArray(Collection<Gpscoordinate> collection) {
        return new JSONSerializer().exclude("*.class").serialize(collection);
    }
    
    public static String Gpscoordinate.toJsonArray(Collection<Gpscoordinate> collection, String[] fields) {
        return new JSONSerializer().include(fields).exclude("*.class").serialize(collection);
    }
    
    public static Collection<Gpscoordinate> Gpscoordinate.fromJsonArrayToGpscoordinates(String json) {
        return new JSONDeserializer<List<Gpscoordinate>>().use(null, ArrayList.class).use("values", Gpscoordinate.class).deserialize(json);
    }
    
}
