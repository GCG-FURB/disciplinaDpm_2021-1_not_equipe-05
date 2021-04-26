package com.furb.devmobile.Mapper.Carro;

import com.furb.devmobile.DTO.Carro.CarroDTO;
import com.furb.devmobile.Entity.Carro.CarroEntity;
import org.springframework.stereotype.Component;

@Component
public class CarroMapper {

    public CarroEntity toEntity(CarroDTO carroDTO) {
        CarroEntity carroEntity = new CarroEntity();
        carroEntity.setNome(carroDTO.nome);
        carroEntity.setMarca(carroDTO.marca);
        carroEntity.setAnoDeFabricacao(carroDTO.anoDeFabricacao);
        return carroEntity;
    }

    public CarroDTO toDTO(CarroEntity carroEntity) {
        CarroDTO carroDTO = new CarroDTO();
        carroDTO.id = carroEntity.getId();
        carroDTO.nome = carroEntity.getNome();
        carroDTO.marca = carroEntity.getMarca();
        carroDTO.anoDeFabricacao = carroEntity.getAnoDeFabricacao();
        return carroDTO;
    }
}
