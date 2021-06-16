package com.qrcode.crud.Service;

import com.qrcode.crud.DTO.LocationDTO;
import com.qrcode.crud.Entity.LocationEntity;
import com.qrcode.crud.Mapper.LocationMap;
import com.qrcode.crud.Repository.LocationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class LocationService {

    @Autowired
    private LocationRepository locationRepository;

    @Autowired
    private LocationMap locationMap;

    public LocationEntity createOrUpdateLocation(LocationDTO locationDTO) {
        LocationEntity locationEntity = this.locationRepository.save(this.locationMap.dtoToEntity(locationDTO));
        return locationEntity;
    }

    public List<LocationDTO> getLocations() {
        List<LocationEntity> locationEntities = this.locationRepository.findAll();
        List<LocationDTO> locationDTOS = new ArrayList<>();
        locationEntities.forEach(locationEntity -> {
            locationDTOS.add(this.locationMap.entityToDto(locationEntity));
        });
        return locationDTOS;
    }

    public LocationDTO getLocationById(long id) {
        Optional<LocationEntity> optionalLocationEntity = this.locationRepository.findById(id);
        return this.locationMap.entityToDto(optionalLocationEntity.get());
    }

    public void deleteLocationById(Long id) {
        this.locationRepository.deleteById(id);
    }
}
