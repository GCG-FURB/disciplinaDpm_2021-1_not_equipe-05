package com.furb.devmobile.Service.Carro;

import com.furb.devmobile.DTO.Carro.CarroDTO;
import com.furb.devmobile.Entity.Carro.CarroEntity;
import com.furb.devmobile.Mapper.Carro.CarroMapper;
import com.furb.devmobile.Repository.Carro.CarroRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CarroService {

    @Autowired
    private CarroMapper carroMapper;

    @Autowired
    private CarroRepository carroRepository;

    public CarroEntity newCar(CarroDTO newCar) {
        CarroEntity carroEntity = carroMapper.toEntity(newCar);
        return carroRepository.save(carroEntity);
    }

    public List<CarroDTO> all() {
        List<CarroEntity> carroEntities = (List<CarroEntity>) carroRepository.findAll();
        List<CarroDTO> carroDTOS = new ArrayList<>();
        carroEntities.forEach(carroEntity -> {
            carroDTOS.add(carroMapper.toDTO(carroEntity));
        });
        return carroDTOS;
    }
}
