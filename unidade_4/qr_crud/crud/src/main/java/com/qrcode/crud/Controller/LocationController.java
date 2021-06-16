package com.qrcode.crud.Controller;

import com.qrcode.crud.DTO.LocationDTO;
import com.qrcode.crud.Entity.LocationEntity;
import com.qrcode.crud.Service.LocationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@CrossOrigin(maxAge = 3600)
@RestController
@RequestMapping("/location")
public class LocationController {

    @Autowired
    private LocationService locationService;

    @PostMapping("/createOrUpdateLocation")
    public LocationEntity createOrUpdateLocation(@RequestBody LocationDTO locationDTO) {
        return locationService.createOrUpdateLocation(locationDTO);
    }

    @GetMapping("/locations")
    public List<LocationDTO> listLocations() {
        return locationService.getLocations();
    }

    @GetMapping("/locations/{id}")
    public LocationDTO getLocationById(@PathVariable("id") Long id) {
        return locationService.getLocationById(id);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity deleteLocationById(@PathVariable("id") Long id) {
        this.locationService.deleteLocationById(id);
        return new ResponseEntity(HttpStatus.OK);
    }
}
