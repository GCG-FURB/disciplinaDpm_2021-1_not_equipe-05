package com.qrcode.crud.Mapper;

import com.qrcode.crud.DTO.LocationDTO;
import com.qrcode.crud.Entity.LocationEntity;
import org.springframework.stereotype.Component;

@Component
public class LocationMap {

    public LocationEntity dtoToEntity(LocationDTO locationDTO) {
        LocationEntity locationEntity = new LocationEntity();
        locationEntity.setId(locationDTO.id);
        locationEntity.setDescription(locationDTO.description);
        locationEntity.setLatitude(locationDTO.latitude);
        locationEntity.setLongitude(locationDTO.longitude);
        return locationEntity;
    }

    public LocationDTO entityToDto(LocationEntity locationEntity) {
        LocationDTO locationDTO = new LocationDTO();
        locationDTO.id = locationEntity.getId();
        locationDTO.description = locationEntity.getDescription();
        locationDTO.latitude = locationEntity.getLatitude();
        locationDTO.longitude = locationEntity.getLongitude();
        return locationDTO;
    }
}
