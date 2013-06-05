// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package de.osramos.ss13.proj1.web;

import de.osramos.ss13.proj1.model.Userdb;
import de.osramos.ss13.proj1.web.UserdbController;
import java.io.UnsupportedEncodingException;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.UriUtils;
import org.springframework.web.util.WebUtils;

privileged aspect UserdbController_Roo_Controller {
    
    @RequestMapping(method = RequestMethod.POST, produces = "text/html")
    public String UserdbController.create(@Valid Userdb userdb, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, userdb);
            return "userdbs/create";
        }
        uiModel.asMap().clear();
        userdb.persist();
        return "redirect:/userdbs/" + encodeUrlPathSegment(userdb.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(params = "form", produces = "text/html")
    public String UserdbController.createForm(Model uiModel) {
        populateEditForm(uiModel, new Userdb());
        return "userdbs/create";
    }
    
    @RequestMapping(value = "/{id}", produces = "text/html")
    public String UserdbController.show(@PathVariable("id") Long id, Model uiModel) {
        uiModel.addAttribute("userdb", Userdb.findUserdb(id));
        uiModel.addAttribute("itemId", id);
        return "userdbs/show";
    }
    
    @RequestMapping(produces = "text/html")
    public String UserdbController.list(@RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        if (page != null || size != null) {
            int sizeNo = size == null ? 10 : size.intValue();
            final int firstResult = page == null ? 0 : (page.intValue() - 1) * sizeNo;
            uiModel.addAttribute("userdbs", Userdb.findUserdbEntries(firstResult, sizeNo));
            float nrOfPages = (float) Userdb.countUserdbs() / sizeNo;
            uiModel.addAttribute("maxPages", (int) ((nrOfPages > (int) nrOfPages || nrOfPages == 0.0) ? nrOfPages + 1 : nrOfPages));
        } else {
            uiModel.addAttribute("userdbs", Userdb.findAllUserdbs());
        }
        return "userdbs/list";
    }
    
    @RequestMapping(method = RequestMethod.PUT, produces = "text/html")
    public String UserdbController.update(@Valid Userdb userdb, BindingResult bindingResult, Model uiModel, HttpServletRequest httpServletRequest) {
        if (bindingResult.hasErrors()) {
            populateEditForm(uiModel, userdb);
            return "userdbs/update";
        }
        uiModel.asMap().clear();
        userdb.merge();
        return "redirect:/userdbs/" + encodeUrlPathSegment(userdb.getId().toString(), httpServletRequest);
    }
    
    @RequestMapping(value = "/{id}", params = "form", produces = "text/html")
    public String UserdbController.updateForm(@PathVariable("id") Long id, Model uiModel) {
        populateEditForm(uiModel, Userdb.findUserdb(id));
        return "userdbs/update";
    }
    
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE, produces = "text/html")
    public String UserdbController.delete(@PathVariable("id") Long id, @RequestParam(value = "page", required = false) Integer page, @RequestParam(value = "size", required = false) Integer size, Model uiModel) {
        Userdb userdb = Userdb.findUserdb(id);
        userdb.remove();
        uiModel.asMap().clear();
        uiModel.addAttribute("page", (page == null) ? "1" : page.toString());
        uiModel.addAttribute("size", (size == null) ? "10" : size.toString());
        return "redirect:/userdbs";
    }
    
    void UserdbController.populateEditForm(Model uiModel, Userdb userdb) {
        uiModel.addAttribute("userdb", userdb);
    }
    
    String UserdbController.encodeUrlPathSegment(String pathSegment, HttpServletRequest httpServletRequest) {
        String enc = httpServletRequest.getCharacterEncoding();
        if (enc == null) {
            enc = WebUtils.DEFAULT_CHARACTER_ENCODING;
        }
        try {
            pathSegment = UriUtils.encodePathSegment(pathSegment, enc);
        } catch (UnsupportedEncodingException uee) {}
        return pathSegment;
    }
    
}
