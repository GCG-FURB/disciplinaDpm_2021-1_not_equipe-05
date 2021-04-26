package com.furb.devmobile.Repository.Carro;

import com.furb.devmobile.Entity.Carro.CarroEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CarroRepository extends CrudRepository<CarroEntity, Long> {
}
